/**********************************************************************
 *	Microsoft SQL Server SQL-DMO scripts, version 6.5.
 *	Date created:  3/17/96.
 *	Copyright Microsoft Corporation, 1992-2000
 **********************************************************************
 *	Updated script for Version Upgrade for SQL Server through version 8.0.  DO NOT
 *	run this script if you have a version of SQLOLE later than 0x00063207.
 **********************************************************************/

use master
go

if exists (select * from master..sysobjects where sysstat & 0x0f = 4 and name = 'sp_MShelpcolumns')
	drop procedure sp_MShelpcolumns
go

if exists (select * from master..sysobjects where sysstat & 0x0f = 4 and name = 'sp_MSdependencies')
	drop procedure sp_MSdependencies
go

if exists (select * from master..sysobjects where sysstat & 0x0f = 4 and name = 'sp_MSobjectprivs')
	drop procedure sp_MSobjectprivs
go

if exists (select * from master..sysobjects where sysstat & 0x0f = 4 and name = 'sp_MShelpcolumns2')
	drop procedure sp_MShelpcolumns2
go


if (@@microsoftversion >= 0x000632c0)
	exec sp_MS_upd_sysobj_category 1


/************* DUMP THE TRANSACTION LOG **************************************/
/* Comment this out if you don't want your log dumped.  If you rerun this    */
/* script periodically, you will run out of transaction log space.           */
print ''
print 'Dumping transaction log...'
print ''
go
dump tran master with no_log
go
/************* END DUMP THE TRANSACTION LOG **********************************/

/*******************************************************************************/
print ''
print 'Creating sp_MShelpcolumns'
print ''
go
create procedure sp_MShelpcolumns
@tablename varchar(92), @flags int = 0, @orderby varchar(10) = null, @flags2 int = 0
as
	if @flags is null
		select @flags = 0
	if (@tablename = '?')
	begin
		print ''
		print 'Usage:  sp_MShelpcolumns @tablename, @flags int = 0'
		print ' where @flags is a bitmask of:'
		print ' 0x0200		= No DRI (ignore Checks, Primary/Foreign/Unique Keys, etc.)'
		print ' 0x0400		= UDDTs --> Base type'
		print ' 0x0800		= 42Syntax (convert numeric/decimal, no identity)'
		print ' 0x80000		= TimestampToBinary (convert timestamp cols to binary(8))'
		print ' 0x40000000	= No Identity attribute'
		return 0
	end

/**********************************/

	declare @objid int, @category int
	select @objid = id, @category = category from sysobjects where id = object_id(@tablename)
	if (@objid is null)
	begin
		RAISERROR (15001, -1, -1, @tablename)
		return 1
	end

	set nocount on

	create table #sphelpcols
	(
		col_name		varchar(30)			NOT NULL,
		col_id			tinyint				NOT NULL,
		col_type		smallint			NOT NULL,
		col_len			tinyint				NOT NULL,
		col_prec		tinyint				NULL,
		col_scale		tinyint				NULL,
		col_numtype		smallint			NOT NULL,	/* For DaVinci to get sp_help-type filtering of prec/scale */
		col_null		bit					NOT NULL,	/* status & 8 */
		col_identity	bit					NOT NULL,	/* status & 128 */
		col_defname		varchar(61)			NULL,		/* fully-qual'd default name, or NULL */
		col_rulname		varchar(61)			NULL,		/* fully-qual'd rule name, or NULL */
		col_basetype	int					NULL,
		col_flags		int					NULL,
		col_seed		int					NULL,
		col_increment	int 				NULL,
		col_dridefname	varchar(30)			NULL,		/* DRI DEFAULT name */
		col_drideftext	varchar(255)		NULL,		/* DRI DEFAULT text */
		col_dridefid	int					NULL,		/* subselect hackaround */
	)

	/* First load stuff so we can blot off inappropriate info and massage as per @flags */
	insert #sphelpcols
		select c.name, c.colid, c.usertype, c.length, c.prec, c.scale,
				-- col_numtype for DaVinci:  use sp_help-type prec/scale filtering for @flags2 & 1
			case when (@flags2 & 1 <> 0 and c.type in (38,48,52,55,56,59,60,62,63,106,108,109,110,122)) then 1 else 0 end,
				-- Nullable
			convert(bit, c.status & 0x0008),
				-- Identity
			case when (@flags & 0x40000000 = 0) then convert(bit, c.status & 0x0080) else 0 end,
				-- Non-DRI Default (make sure it's not a DRI constraint).
			case when (c.cdefault = 0) then null when (d.category & 0x0800 <> 0) then null else user_name(d.uid) + '.' + d.name end,
				-- Non-DRI Rule
			case when (c.domain = 0) then null else user_name(r.uid) + '.' + r.name end,
				-- Physical base datatype
			case when (c.usertype < 100) then c.usertype else bt.usertype end,
				-- Initialize flags to whether it's a length-specifiable type, or a numeric type, or 0.
			case when c.usertype in (1, 2, 3, 4) then 0x0001 when c.usertype in (10, 24, 25, 26) then 0x0002 else 0 end,
				-- Identity seed and increment
			case when (c.status & 0x0080 = 0) then null else ident_seed(@tablename) end,
			case when (c.status & 0x0080 = 0) then null else ident_incr(@tablename) end,
				-- DRI Default name
			case when (@flags & 0x0200 = 0 and d.category & 0x0800 <> 0) then object_name(c.cdefault) else null end,
				-- DRI Default text, if it does not span multiple rows (if it does, SQLOLE will go get them all).
			case when (@flags & 0x0200 = 0 and d.category & 0x0800 <> 0)
					then t.text else null end,
				-- Hackaround for a subselect bug
			c.cdefault
		from syscolumns c, sysobjects d, sysobjects r, systypes bt, syscomments t
		where c.id = object_id(@tablename)
				-- NonDRI Default and Rule filters
			and d.id =* c.cdefault and r.id =* c.domain
				-- Physical base type
			and bt.type =* c.type and bt.usertype < 99 and bt.usertype not in (18, 80)
				-- DRIDefault text, if it's only one row.
			and t.id =* c.cdefault and t.colid = 1

	/* Could not do this on the fly as the subselect is not properly processed. */
	/* An "and not exists" fails on 6.0 due to parser bug so this is the only way to make both work. */
	if (@flags & 0x0200 = 0)
		update #sphelpcols set col_drideftext = NULL
			where col_dridefid is not NULL
			and exists (select * from syscomments where id = col_dridefid and colid = 2)

	/* Convert any timestamp column to binary(8) if they asked. */
	if (@flags & 0x80000 != 0)
		update #sphelpcols set col_type = 3, col_len = 8, col_flags = col_flags | 0x0001 where col_type = 80

	/* Convert from the dblib-specific 'nullable' type to something people and the server recognize. */
	update #sphelpcols set col_type = case col_type
			when 15 then 12	/* datetime --> datetimn */
			when 26 then 24	/* decimal --> decimaln */
			when 14 then 8	/* float --> floatn */
			when 13 then 7	/* int --> intn*/
			when 17 then 11	/* money --> moneyn*/
			when 25 then 10	/* numeric --> numericn */
			else col_type end,
		col_basetype = case col_basetype
			when 15 then 12	/* datetime --> datetimn */
			when 26 then 24	/* decimal --> decimaln */
			when 14 then 8	/* float --> floatn */
			when 13 then 7	/* int --> intn*/
			when 17 then 11	/* money --> moneyn*/
			when 25 then 10	/* numeric --> numericn */
			else col_basetype end

	/* Now see what our flags are, if anything.  Ignore the physical base type here -- these */
	/* flags are just for scripting, which doesn't use that. */
	if (@flags is not null and @flags != 0)
	begin
		if (@flags & 0x0400 != 0)
		begin
			/* Track from usertype --> b.<base>type --> u.usertype in systypes */
			update #sphelpcols set col_type = u.usertype,
				-- ReInitialize flags to whether it's a length-specifiable type, or a numeric type, or 0.
				col_flags = case when u.usertype in (1, 2, 3, 4) then 0x0001 when u.usertype in (10, 24) then 0x0002 else 0 end
			 from #sphelpcols c, systypes b, systypes u
			where c.col_type > 100 and b.usertype = c.col_type and b.type = u.type and u.usertype < 100 and u.usertype not in (18, 80)
		end
		/* Modifided to allow Identity if NoDRI.  This is like a new datatype; OK unless 42Syntax is specified. */
		if (@flags & 0x0800 != 0)
		begin
			update #sphelpcols				/* No IDENTITY */
				set col_identity = 0
			update #sphelpcols				/* Convert numeric and decimal with prec < 8 to real */
				set col_type = 23 where col_type in (10, 24) and col_prec < 8
			update #sphelpcols				/* Convert numeric and decimal with prec >= 8 to float */
				set col_type = 8 where col_type in (10, 24)	and col_prec >= 8
		end
	end

	/* Determine if the column is in the primary key */
	if (@flags & 0x0200 = 0 and @category & 0x200 <> 0) begin
		declare @indid int
		select @indid = indid from sysindexes i where i.id = @objid and i.status & 0x0800 <> 0

		/* There can't be more columns in an index than there are in a table, so use the col_id's */
		/* to form a numeric sequence to query the index_col ordinals.  Note that this does NOT */
		/* imply a relationship between the col_id and the name returned for it; in fact they will */
		/* not be the same unless the first x columns are the index columns, in order.  col_id is */
		/* ONLY used to form an unbroken numeric sequence to query index_col; the #sphelpcols */
		/* update by name is a separate step. */
		if (@indid is not null)
			update #sphelpcols set col_flags = col_flags | 0x0004 where col_name in
				(select index_col(@tablename, @indid, col_id) from #sphelpcols where col_id <= 16)
	end

	/* OK, now put out the data.  @flags2 added for DaVinci; currently only bit 1 (sp_help filtering of prec/scale) is relevant. */
	set nocount off
	if (@orderby is null or @orderby = 'id')
	begin
		select c.col_name, c.col_id, DataType = t.name, c.col_len,
					-- Prec/scale only for numeric/decimal
				col_prec = case when (col_basetype in (10, 24) or (@flags2 & 1 <> 0 and col_numtype & 1 <> 0))
						then c.col_prec else NULL end,
				col_scale = case when (col_basetype in (10, 24) or (@flags2 & 1 <> 0 and col_numtype & 1 <> 0))
						then c.col_scale else NULL end,
				BaseType = b.name, c.col_defname, c.col_rulname, c.col_null, c.col_identity,
				c.col_flags, c.col_seed, c.col_increment, c.col_dridefname, c.col_drideftext
		from #sphelpcols c, systypes t, systypes b
		where t.usertype = c.col_type and b.usertype = c.col_basetype
		order by c.col_id
	end else begin
		select c.col_name, c.col_id, DataType = t.name, c.col_len,
					-- Prec/scale only for numeric/decimal
				col_prec = case when (col_basetype in (10, 24) or (@flags2 & 1 <> 0 and col_numtype & 1 <> 0))
						then c.col_prec else NULL end,
				col_scale = case when (col_basetype in (10, 24) or (@flags2 & 1 <> 0 and col_numtype & 1 <> 0))
						then c.col_scale else NULL end,
				BaseType = b.name, c.col_defname, c.col_rulname, c.col_null, c.col_identity,
				c.col_flags, c.col_seed, c.col_increment, c.col_dridefname, c.col_drideftext
		from #sphelpcols c, systypes t, systypes b
		where t.usertype = c.col_type and b.usertype = c.col_basetype
		order by c.col_name
	end

go
/* End sp_MShelpcolumns */


/************* DUMP THE TRANSACTION LOG **************************************/
/* Comment this out if you don't want your log dumped.  If you rerun this    */
/* script periodically, you will run out of transaction log space.           */
print ''
print 'Dumping transaction log...'
print ''
go
dump tran master with no_log
go
/************* END DUMP THE TRANSACTION LOG **********************************/

/*******************************************************************************/
print ''
print 'Creating sp_MSdependencies'
print ''
go

create procedure sp_MSdependencies
@objname varchar(92) = null, @objtype int = null, @flags int = 0x01fd, @objlist varchar(30) = null
as
	if (@objname = '?')
	begin
		print 'sp_MSobject_dependencies name = NULL, type = NULL, flags = 0x01fd'
		print '  name:  name or null (all objects of type)'
		print '  type:  type number (see below) or null'
		print '	  if both null, get all objects in database'
		print '  flags is a bitmask of the following values:'
		print '	  0x10000  = return multiple parent/child rows per object'
		print '	  0x20000  = descending return order'
		print '	  0x40000  = return children instead of parents'
		print '	  0x80000  = Include input object in output result set'
		print '	  0x100000 = return only firstlevel (immediate) parents/children'
		print '	  0x200000 = return only DRI dependencies'
		print '	  power(2, object type number(s))  to return in results set:'
		print '		  0 (1  	- 0x0001)	 - datatype'
		print '		  1 (2  	- 0x0002)	 - system tables or MS-internal objects'
		print '		  2 (4  	- 0x0004)	 - view'
		print '		  3 (8  	- 0x0008)	 - user table'
		print '		  4 (16		- 0x0010)	 - procedure'
		print '		  5 (32		- 0x0020)	 - log'
		print '		  6 (64 	- 0x0040)	 - default'
		print '		  7 (128	- 0x0080)	 - rule'
		print '		  8 (256	- 0x0100)	 - trigger'
		print '	  shortcuts:'
		print '		  29	 (0x011c) - trig, view, user table, procedure'
		print '		  448	(0x00c1) - rule, default, datatype'
		print '		  509	(0x01fd) - all but systables/objects'
		print '		  511	(0x01ff) - all'
		return 0
	end


	/*
	 * If this proc is called in a tight loop, it tends to fill up the log in a small tempdb too fast
	 * for the trunc. log on chkpt thread to keep up.  So help it out here.
	 */
	declare @dumptranpriv varchar(12)
	select @dumptranpriv = ltrim(str(convert(int, 0x0040)))
	exec ('if exists (select * from #SQLOLEDbUserProfile where dbid = db_id(''tempdb'') '
		+ ' and profilebits & ' + @dumptranpriv + ' = ' + @dumptranpriv + ') '
		+ ' dump tran tempdb with no_log')



	/* If they want SQLOLEDep_DRIOnly, remove all but usertable objects from @flags */

	if (@flags & 0x200000 <> 0)
		select @flags = (@flags & ~convert(int, 0x01ff)) | power(2, 3)


	if (@objtype in (0, 5, 6, 7))
	begin
		/* Print only, do not raiserror as we may be calling this blindly and this is not a real error. */
		print 'Rules, defaults, and datatypes do not have dependencies.'
		return (0)
	end

	/*
	 * Create #t1 and #t2 as temp object holding areas.  Columns are:
	 *	 tid		- temp object id
	 *	 ttype	 - temp object type
	 *	 pid		- parent or child object id
	 *	 ptype	 - parent or child object type
	 *	 bDone	 - NULL means dependencies not yet evaluated, else nonNULL.
	 */
	declare @curid int, @curcat int, @rowsaffected int
	declare @allobjs int
	declare @delinputobj int
	select @allobjs = 0, @delinputobj = 0, @curid = NULL, @curcat = NULL
	create table #t1 (
		tid				int				NULL,
		ttype			smallint		NULL,
		tcat			smallint		NULL,
		pid				int				NULL,
		ptype			smallint		NULL,
		pcat			smallint		NULL,
		bDone			smallint		NULL
	)
	create table #t2 (
		tid				int				NULL,
		ttype			smallint		NULL,
		tcat			smallint		NULL,
		pid				int				NULL,
		ptype			smallint		NULL,
		pcat			smallint		NULL,
		bDone			smallint		NULL
	)
	create table #tempudt (
		dtype			int				NOT NULL
	)

	/* Worktables we'll use for optimization.  #t3 and #t4 push us over the 64 2K page limit in 4.21, */
	/* but the real gain is from #temptrig anyway. */

	create table #t3 (
		tid				int				NOT NULL
	)
	create table #t4 (
		tid				int				NOT NULL
	)
	create clustered index #ci_t3 on #t3(tid) with allow_dup_row
	create clustered index #ci_t4 on #t4(tid) with allow_dup_row

	create table #temptrig(
		id				int				NOT NULL,
		deltrig			int				NOT NULL,
		sysstat			smallint		NOT NULL,
		category		int				NOT NULL
	)
	create clustered index #ci_temptrig on #temptrig (deltrig) with allow_dup_row

	

	/*
	 * If both name and type are null, this means get every object in the
	 * database matching the specification they passed in.  Otherwise,
	 * find the passed object or all objects of the passed type.  Start off
	 * loading parent info (pid, tid); these will be put into child as needed.
	 * If Objlist is specified we simply load its contents into #t1.
	 */

	if (@objlist is not null)
	begin
		declare @mscategory varchar(12)
		select @mscategory = ltrim(str(convert(int, 0x0002)))

		exec('insert #t1 (pid, ptype, pcat) select l.objid, l.objtype, o.category &' +  @mscategory +
				' from ' + @objlist + ' l, sysobjects o where o.id = l.objid ')
	end else begin

		if (@objname is null and @objtype is null)
		begin
			set nocount on
			select @allobjs = 1
			insert #t1 (pid, ptype, pcat) select o.id, o.sysstat & 0x0f, o.category & 0x0002 from sysobjects o
				where ((power(2, o.sysstat & 0x0f) & 0x01ff) <> 0) and (o.sysstat & 0x0f not in (6, 7))
		end else begin
			if (@objname is not null)
			begin
				select @curid = id, @objtype = o.sysstat & 0x0f, @curcat = o.category & 0x0002 from sysobjects o where id = object_id(@objname)
				if (@curid is null)
				begin
					
					RAISERROR (15001, -1, -1, @objname)
					return 1
				end
				if (@flags & 0x80000 = 0)
					select @delinputobj = @curid
			end

			set nocount on
			if (@curid is null)
				insert #t1 (pid, ptype, pcat) select o.id, o.sysstat & 0x0f, o.category & 0x0002 from sysobjects o
					where o.sysstat & 0x0f = @objtype
			else
				insert #t1 (pid, ptype, pcat) values (@curid, @objtype, @curcat)
		end

	end

	/*
	 * All initial objects are loaded as parents/children.  Now we loop, creating
	 * rows of child/parent relationships.  Use #t2 as a temp area for the selects
	 * to simulate recursion; when they find no rows, we're done with this step.
	 *
	 * Note that triggers are weird; they're part of a table definition but can
	 * also reference other tables, so we need to evaluate them both ways.  SQL
	 * Server stores the table for a trigger object as its deltrig; if a trigger
	 * references another table, that relationship is stored in sysdepends.
	 * This peculiarity of triggers requires separating the object-retrieval pass
	 * from the creation-sequence pass (below).  Also, the fact that trigger tables
	 * are stored in a non-indexed column (deltrig) requires us to use a worktable
	 * if we're returning triggers, so we don't continually tablescan sysobjects.
	 */

	if (@flags & power(2, 8) != 0)
		insert #temptrig select d.id, d.deltrig, d.sysstat, d.category from sysobjects d where d.sysstat & 0x0f = 8

	while (select count(*) from #t1 where bDone is null) > 0
	begin
		/*
		 * Remove Microsoft-internal or other system objects from #t1, unless
		 * @flags specified including system tables.  We do this here so that
		 * cascaded system dependencies are not included unless specifically
		 * requested.  For other restrictions, we wait until below so that all
		 * cascaded object types are fully evaluated.
		 */
		if (@flags & power(2, 1) = 0)
			delete #t1 where ttype = 1 or tcat = 0x0002 or pcat = 0x0002

		if (@flags & 0x40000 != 0)
		begin
			if (@flags & 0x200000 = 0) begin
				/* Table --> Triggers */
				if (@flags & power(2, 8) != 0)
					insert #t2 (tid, ttype, tcat, pid, ptype, pcat)
						select distinct t.pid, t.ptype, t.pcat, o.id, o.sysstat & 0x0f, o.category & 0x0002 from #t1 t, #temptrig o
							where t.bDone is null and t.ptype = 3 and o.deltrig = t.pid

				/* Object --> sysdepends children */
				insert #t2 (tid, ttype, tcat, pid, ptype, pcat)
					select distinct t.pid, t.ptype, t.pcat, d.id, o.sysstat & 0x0f, o.category & 0x0002
					from #t1 t, sysdepends d, sysobjects o
					where t.bDone is null and d.depid = t.pid and d.id = o.id
			end

			/* Object --> sysreferences children (FK tables referencing this one) */
			insert #t2 (tid, ttype, tcat, pid, ptype, pcat)
				select distinct t.pid, t.ptype, t.pcat, r.fkeyid, o.sysstat & 0x0f, o.category & 0x0002
				from #t1 t, sysreferences r, sysobjects o
				where t.bDone is null and r.rkeyid = t.pid and r.fkeyid = o.id

		end else begin
			if (@flags & 0x200000 = 0) begin
				/* Trigger --> Table */
				if (@flags & power(2, 3) != 0)
					insert #t2 (tid, ttype, tcat, pid, ptype, pcat)
						select distinct t.pid, t.ptype, t.pcat, o.deltrig, u.sysstat & 0x0f, u.category & 0x0002
							  from #t1 t, sysobjects o, sysobjects u
							where t.bDone is null and t.ptype = 8 and o.id = t.pid and o.deltrig != 0 and u.id = o.deltrig

				/* Object --> sysdepends parents */
				insert #t2 (tid, ttype, tcat, pid, ptype, pcat)
					select distinct t.pid, t.ptype, t.pcat, d.depid, o.sysstat & 0x0f, o.category & 0x0002
					from #t1 t, sysdepends d, sysobjects o
					where t.bDone is null and d.id = t.pid and d.depid = o.id
			end

			/* Object --> sysreferences parents (PK/UQ tables referenced by one) */
			insert #t2 (tid, ttype, tcat, pid, ptype, pcat)
				select distinct t.pid, t.ptype, t.pcat, r.rkeyid, o.sysstat & 0x0f, o.category & 0x0002
				from #t1 t, sysreferences r, sysobjects o
				where t.bDone is null and r.fkeyid = t.pid and r.rkeyid = o.id

		end

		/*
		 * We have this generation of parents in #t2, so clear the current
		 * child generation's bDone flags.  Then insert from #t2; the current
		 * parent generation becomes the next loop's child generation, with
		 * bDone = null until next loop's dependencies are selected.
		 */
		update #t1 set bDone = 1
		insert #t1 select * from #t2 where #t2.tid not in
			(select tid from #t1 where #t1.tid = #t2.tid and #t1.pid = #t2.pid)
		truncate table #t2

		/* If they only want one level, we're done.	*/
		if (@flags & 0x100000 <> 0)
			update #t1 set bDone = 1
	end

	/*
	 * The inner loop above did not put parents with no parents into the
	 * child (tid) list.  Do that now, then remove all rows where tid is
	 * NULL, because these were initial objects which now have a tid row.
	 * Just in case, remove self-refs from #t1, and also remove rows from #t1
	 * with NULL pid if a row exists for that tid where the pid is nonNULL.
	 * Avoid nested self-joins by using worktables.
	 */

	truncate table #t3
	insert #t3 select tid from #t1 where tid is not null
		and tid <> pid				-- make sure self-refs with no other refs go in child list
	update statistics #t3 #ci_t3
	insert #t1 (tid, ttype, tcat, bDone) select distinct pid, ptype, pcat, 0 from #t1 t
		where t.pid is not null and not exists (select * from #t3 where tid = t.pid)
	delete #t1 where tid = pid		-- now remove self-refs





	/*
	 * Because triggers can go in both directions, we'll need to check for
	 * circular dependencies on parent evaluation.  Since any tables referenced
	 * by the trigger must exist before the trigger can be created, remove rows
	 * where the trigger is the parent.
	 */
	if (@flags & 0x40000 = 0)
		delete #t1 where ptype = 8


	truncate table #t3
	insert #t3 select tid from #t1 where tid is not null and pid is not null
	update statistics #t3 #ci_t3
	delete #t1 where #t1.tid is null or #t1.tid = #t1.pid
		or (#t1.pid is null and exists (select * from #t3 where tid = #t1.tid))





	/*
	 * If we're to get all objects, get all UDDTs (which aren't in sysobjects)
	 * and Rules/Defaults, assuming we're returning those types.
	 */
	if (@allobjs <> 0)
	begin
		if (@flags & power(2, 0) != 0)
			insert #tempudt
				select usertype from systypes where usertype > 99
		if (@flags & (power(2, 7) | power(2, 6)) != 0)
			insert #t2 (tid, ttype, tcat)
				select id, sysstat & 0x0f, 0 from sysobjects
				where sysstat in (7, 6)
				and category & 0x0800 = 0
	end else begin
		/*
		 * Not getting all objects.  Get any datatypes that
		 * are referenced by objects in #t1.  We don't care about specific
		 * datatype dependencies, we just want to know which ones are needed.
		 */
		if (@flags & power(2, 0) != 0)
			insert #tempudt select distinct usertype from syscolumns
				where usertype > 99 and id in (select tid from #t1)

		/*
		 * Load rules and defaults needed by datatypes and other #t1 objects
		 * into #t2.  Don't track specific object dependencies with these;
		 * we just want to know which ones are needed.  For defaults only, eliminate
		 * those which are constraints.
		 */
		if (@flags & power(2, 7) != 0)
		begin
			insert #t2 (tid, ttype, tcat)
				select distinct s.domain, 7, 0 from systypes s, #tempudt t
					where s.domain != 0 and s.usertype = t.dtype
						and s.domain not in (select tid from #t1)
			insert #t2 (tid, ttype, tcat)
				select distinct s.domain, 7, 0 from syscolumns s, #t1 t
					where s.domain != 0 and s.id = t.tid
						and s.domain not in (select tid from #t1)
		end
		if (@flags & power(2, 6) != 0)
		begin
			insert #t2 (tid, ttype, tcat)
				select distinct s.tdefault, 6, 0 from systypes s, #tempudt t
					where s.tdefault != 0 and s.usertype = t.dtype
						and s.tdefault not in (select tid from #t1)
						and s.tdefault not in (select id from sysobjects where category & 0x0800 != 0)
			insert #t2 (tid, ttype, tcat)
				select distinct s.cdefault, 6, 0 from syscolumns s, #t1 t
					where s.cdefault != 0 and s.id = t.tid
						and s.cdefault not in (select tid from #t1)
						and s.cdefault not in (select id from sysobjects where category & 0x0800 != 0)
		end
	end		/* Not getting all objects */

	/*
	 * Now that we've got all objects we want, eliminate those we don't
	 * want to return.  If @inputobj and they don't want it returned,
	 * remove it from the table.  Then eliminate object types they don't
	 * want returned.  Make sure that in doing so we retain all parent
	 * objects of the types we do want -- it is possible at this point
	 * that a tid we want has no rows except those with pids we don't want.
	 */
	if (@flags & 0x01ff != 0x01ff or @delinputobj != 0)
	begin
		delete #t1 where @flags & power(2, ttype) = 0 or tid = @delinputobj

		/*
		 * Be sure that the insert does not duplicate rows that will survive the
		 * following delete -- these are rows where the pid is not @delinputobj
		 * and ptype is either null or a type we'll keep (if ptype is null then
		 * pid hasn't been set so no need for more complex checking).
		 */
		insert #t1 (tid, ttype, tcat) select distinct tid, ttype, tcat from #t1
			where (@flags & power(2, ptype) = 0 or pid = @delinputobj)
				and tid not in (select tid from #t1 where ptype is null or
					(pid != @delinputobj and @flags & power(2, ptype) != 0))
		delete #t1 where @flags & power(2, ptype) = 0 or pid = @delinputobj
	end

	/*
	 * To determine creation order, find all objects which are not yet bDone
	 * and have no parents or whose parents are all bDone, and set their bDone
	 * to the next @curid.  This will leave bDone as the ascending order in
	 * which objects must be created (topological sort).  Again, use worktables
	 * to remove nested self-joins.
	 */
	update #t1 set bDone = 0
	select @curid = 1, @rowsaffected = 1
	while (@rowsaffected <> 0)
	begin

		if (@flags & 0x40000 != 0) begin
			truncate table #t3
			insert #t3 select pid from #t1 where pid is not null and bDone = 0
			update statistics #t3 #ci_t3
			update #t1 set bDone = @curid where bDone = 0 and tid not in (select tid from #t3)
		end else begin
			truncate table #t3
			truncate table #t4
			insert #t3 select tid from #t1 where bDone = 0				/* Parents not yet done */
			update statistics #t3 #ci_t3
			insert #t4 select tid from #t1								/* TIDs with (parents not yet done) */
				where pid is not null and pid in (select tid from #t3)
			update statistics #t4 #ci_t4
			update #t1 set #t1.bDone = @curid where #t1.bDone = 0 		/* TIDs who are not (TIDs with (parents not yet done)) */
				and not exists (select * from #t4 where tid = #t1.tid)
		end









		select @rowsaffected = @@rowcount, @curid = @curid + 1
	end

	/* For SQL60 only, we need to check circular dependencies (DRI for tables is the only way to get them). */
	/* This will have occurred if we still have any rows in #t1 where bDone = 0, after the above loop. */
	/*
	 * At this point, these are indirect (a->b->...->a), and can only be created by:
	 * 	create table a; create table b ref a; alter table a ref b
	 * There is thus no way to create the tables in a single pass.  Further, the ALTER
	 * TABLE B must be done AFTER data has been added (else the PK/FK will fail).
	 * Therefore, the two-step model of
	 *  - Create tables (and other objects)
	 *  - Transfer data
	 * does not work, so assume anyone doing this will do it in three passes (e.g. ScriptTransfer):
	 *  - Create tables (and other objects) but no references (also defer some indexing, for perfomance)
	 *  - Transfer data
	 *  - Create references (and deferred indexing)
	 * and just set bDone for everything remaining to @curid.
	 */

	if exists (select * from #t1 where bDone = 0) begin
		--select "Circular Dependencies", object_name(tid) from #t1 where bDone = 0
		--RAISERROR (14300, -1, -1)
		--return 1
		update #t1 set bDone = @curid where bDone = 0
	end


	/*
	 * Finally, return the objects.  Rules/Defaults must be created first so they're returned first,
	 * followed by UDDTs. followed by all other (sysdepends/DRI) dependencies.  @curid is the bDone
	 * value; we need to increment the #t1 value so our multi-result-set is in the proper sequence.
	 * Of course, these never have parents, so don't return them if asking for children.
	 */
	if (@flags & 0x40000 = 0) begin
		select @curid = 1
		if ((@flags & (power(2, 7) | power(2, 6)) != 0) and exists (select * from #t2)) begin
			update #t1 set bDone = bDone + 1
			select distinct oType = power(2, o.sysstat & 0x0f), oRuleDefName = o.name, oOwner = user_name(o.uid), oSequence = convert(smallint, @curid)
				from sysobjects o, #t2 t
				where o.id = t.tid
				order by power(2, o.sysstat & 0x0f), o.name
			select @curid = @curid + 1
		end
		if ((@flags & power(2, 0) != 0) and exists (select * from #tempudt)) begin
			update #t1 set bDone = bDone + 1
			select distinct oType = power(2, 0), oUDDTName = c.name, oOwner = user_name(c.uid), oSequence = convert(smallint, @curid)
				from systypes c, #tempudt t, sysobjects p
				where c.usertype = t.dtype
				order by c.name
			select @curid = @curid + 1
		end
	end

	/*
	 * Select dependency-style objects, returning parents if desired.
	 * Normally sorting is in terms of who must be created first, i.e. ascending:  parent-->child-->grandchild.
	 * Descending order (child-->parent-->grandparent) would be used for a graphical-dependencies evaluator showing
	 * the parents.  Therefore we invert bDone if descending sort.  bDone is 1-based; min + max - bDone gives inversion.
	 * Note:  Always return at least this empty set.
	 */
	if (@flags & 0x20000 != 0) begin
		select @curid = max(bDone) + min(bDone) from #t1
		update #t1 set bDone = convert(smallint, @curid) - bDone
	end
	if (@flags & 0x10000 != 0)
		select distinct oType = power(2, o.sysstat & 0x0f), oObjName = o.name, oOwner = user_name(o.uid),
				RelType = power(2, p.sysstat & 0x0f), RelName = p.name, RelOwner = user_name(p.uid),
				oSequence = t.bDone
			from sysobjects o, sysobjects p, #t1 t
			where o.id = t.tid and p.id =* t.pid
			order by t.bDone, power(2, o.sysstat & 0x0f), o.name
	else
		select distinct oType = power(2, o.sysstat & 0x0f), oObjName = o.name, oOwner = user_name(o.uid),
				oSequence = t.bDone
			from sysobjects o, #t1 t
			where o.id = t.tid
			order by t.bDone, power(2, o.sysstat & 0x0f), o.name

go
/* End sp_MSdependencies */



/************* DUMP THE TRANSACTION LOG **************************************/
/* Comment this out if you don't want your log dumped.  If you rerun this    */
/* script periodically, you will run out of transaction log space.           */
print ''
print 'Dumping transaction log...'
print ''
go
dump tran master with no_log
go
/************* END DUMP THE TRANSACTION LOG **********************************/

/*******************************************************************************/
print ''
print 'Creating sp_MSobjectprivs'
print ''
go

create proc sp_MSobjectprivs
	@objname varchar(92) = null,
	@mode varchar(10) = 'object',	/* or 'user' */

/*
 * Note:  This was expanded for 6.5 due to changes in sysprotects.columns usage, affecting
 * CPermission::ListPrivilegeColumns.  The following additional parameters are for this.
 */
	@objid int = null,				/* ID of the object we're querying */
	@srvpriv int = null,			/* privilege that we're querying for (e.g. select) */
	@prottype int = null,			/* Protect type, e.g. GRANT/REVOKE */
	@grantee varchar(30) = null		/* Grantee name. */
as
	/* If @objid is not null, this is for the new query for perm cols. */
 if (@@microsoftversion > 0x000632c0) begin
	if (@objid is not null) begin
		select u.name, o.name, a = col_name(p.id, a.number), a.low, a.high, a.number
			from master.dbo.spt_values a, sysprotects p, sysobjects o, sysusers u
			where p.id = @objid and p.action = @srvpriv and p.protecttype = @prottype
			and p.uid = user_id(@grantee)
			and p.columns != 0x01 and o.id = p.id and u.uid = o.uid
				and convert(tinyint, substring(isnull(p.columns, 0x01), a.low, 1)) &

					-- 6.5 changed so that the bit 0 position is an "invert the bits" indicator:
					--		when 0, behaviour is the same as in prior versions, and other bits
					--			indicate columns with the specified privilege
					--		when 1, the other bits are indicate columns lacking the specified privilege
					a.high <>
                  case when (@@microsoftversion > 0x000632c0) then
                     (case when (substring(isnull(p.columns, 0x00), 1, 1) & 1 = 0) then 0 else a.high end)
                  else
                     0
                  end
					and col_name(p.id, a.number) is not null

					and a.type = 'P' and a.number <= (select count(*) from syscolumns where id = @objid) order by a
		return 0
	end
 end

	set nocount on

	/*
	 * To get around a 4.21 subquery bug where returning count(*) of 0 (for proc cols)
	 * causes the result set to return no rows, we need two passes; one to get the
	 * objects, and another to explicitly use a value (@cols) instead of a subquery.
	 */
	declare @id int, @uid int, @cols int
	select @id = null, @uid = null
	if (@mode like 'us%')
		select @uid = user_id(@objname)
	else
		select @id = object_id(@objname)
	if (@id is null and @uid is null) begin
		
		
		RAISERROR (15001, -1, -1, @objname)
		return 1
	end

	/* Get a temp list of objects we're interested in.  Do not include repl_* users. */
	create table #objs(
		id					int				NOT NULL
	)

 if (@@microsoftversion > 0x000632c0) begin
  /* If 6.5 db was restored from 6.0, sysprotects might contain rows for REVOKE, and we don't want that */
	 insert #objs select distinct p.id from sysprotects p
		 where (@id is null or p.id = @id)
		 and (@uid is null or p.uid = @uid)
		 and p.action in (193, 195, 196, 197, 224, 26) and p.uid not in (16382, 16383)
   and p.protecttype <> 206
 end
 else begin
  /* On 6.0, sysprotects contains rows for REVOKE, and we don't want that */
	 insert #objs select distinct p.id from sysprotects p
		 where (@id is null or p.id = @id)
		 and (@uid is null or p.uid = @uid)
		 and p.action in (193, 195, 196, 197, 224, 26) and p.uid not in (16382, 16383)
   and p.protecttype <> 206
 end

	/* Temp table will hold output for final select */
 if (@@microsoftversion > 0x000632c0) begin
	 create table #output (
		 action				   int    NOT NULL,
		 colid			    	int    NOT NULL,
		 uid					     int    NOT NULL,
		 protecttype		int    NOT NULL,
		 id					      int    NOT NULL
	 )
 end
 else begin
  /* If running on 6.0 server, use different datatypes to match the source tables. */
	 create table #output60 (
		 action				   tinyint     NOT NULL,
		 colid			    	smallint    NOT NULL,
		 uid					     smallint    NOT NULL,
		 protecttype		tinyint     NOT NULL,
		 id					      int         NOT NULL
	 )
 end

	create table #tmp(
		action 			int				NOT NULL,
		uid		     int    NOT NULL,
	)

	/* Use a "fake cursor" by deleting successive id's from #objs, as this must run on 4.21 */
 if (@@microsoftversion > 0x000632c0) begin
 	select @id = min(id) from #objs
  while (@id is not null) begin
  select @cols = count(*) from syscolumns c where c.id = @id
  insert #output select p.action, a.number, p.uid, p.protecttype, p.id
   from master.dbo.spt_values a, sysprotects p
   where convert(tinyint, substring( isnull(p.columns, 0x01), a.low, 1)) & a.high !=0
   and (p.id = @id) and (@uid is null or p.uid = @uid) and a.number <= @cols and a.type = 'P'
   /* If 6.5 db was restored from 6.0, sysprotects might contain rows for REVOKE on 'public', we don't want that, since it should not happen on 6.5 */
   and not (p.uid = 0 and p.protecttype = 206)

   declare @count int, @whataction int, @whatid int
   select @count = count(*) from #output where id = @id and colid = 0
   if ( @count > 0 ) begin
      /* use another fake cursor to correct the protecttype */
      /* if there are multiple rows in #output for the same id and action, and if colid = 0 exist, then other rows should have 206, not 205 */
      insert #tmp select action, uid from #output where id = @id and colid = 0
     	select @whataction = min(action) from #tmp
     	select @whatid = uid from #tmp where action = @whataction
      while (@whataction is not null) begin
       		update #output set protecttype = 206 where id = @id and colid <> 0 and @whataction = action and @whatid = uid
         delete #tmp where action = @whataction and @whatid = uid
         select @whataction = min(action) from #tmp
     	   select @whatid = uid from #tmp where action = @whataction
      end
      delete #tmp
   end

   /* Increment our "fake cursor" column and get the next one. */
   delete #objs where id = @id
   select @id = min(id) from #objs
  end
 end
 else begin
 select @id = min(id) from #objs
  while (@id is not null) begin
	 	select @cols = count(*) from syscolumns c where c.id = @id

   insert #output60 select p.action, a.number, p.uid, p.protecttype, p.id
	   from master.dbo.spt_values a, sysprotects p
	   where (convert(tinyint, substring( isnull(p.columns, 0x01), a.low, 1)) & a.high !=0)
	   and (p.id = @id) and (@uid is null or p.uid = @uid) and a.number <= @cols order by p.uid, p.id, p.protecttype

  /* Increment our "fake cursor" column and get the next one. */
  delete #objs where id = @id
  select @id = min(id) from #objs
  end
 end

	/*
	 * Organize so that the non-collist privileges are returned first.. this allows
	 * scripting to combine them.  sysprotects.action is tinyint, so the hibyte won't conflict.
	 */

 if (@@microsoftversion > 0x000632c0)
    update #output set action = action | 0x10000000 where colid <> 0

	/*
	 * Order output by uid so Public will script before other groups (we need to script privs for public before
	 * other groups, before users; otherwise sysprotects doesn't hold onto things right).  Sub-order is by object id
	 * so we know when we're done with one object and onto the next, then by protecttype to group all GRANTs and
	 * REVOKEs together, and lastly by action (including ORDER_ACTION_BIT so scripting can be more efficient)
	 * because we may have multiple rows for columns.
	 */
 declare @type char(2)
 if (@@microsoftversion > 0x000632c0) begin
 	/* !!! Hack for 7.0 Convert utility !!!
	  * 6.5 is less restrictive about permissions, if we are in object mode,
	  * filter out incorrect permissions, so script transfer to 7.0 works correctly
 	*/
	 if (@mode not like 'us%') begin
 		select @id = object_id(@objname)
	 	select @type = o.type from sysobjects o where o.id = @id
		 if (@type = 'V')
			 delete #output where id = @id and (action = 224 or action = 26)
 		if (@type = 'U')
	 		delete #output where id = @id and action = 224
		 if (@type = 'P' or @type = 'X')
			 delete #output where id = @id and action <> 224
 	end
	 set nocount off
  select p.action & ~convert(int, 0x10000000), 'column' = col_name(p.id, p.colid), p.uid, 'username' = user_name(p.uid),
	 		p.protecttype, o.name, 'owner' = user_name(o.uid), p.id from #output p, sysobjects o where o.id = p.id order by p.uid, p.id, p.protecttype, p.action
 end
 else begin
 	/* !!! Hack for 7.0 Convert utility !!!
	  * 6.5 is less restrictive about permissions, if we are in object mode,
	  * filter out incorrect permissions, so script transfer to 7.0 works correctly
 	*/
	 if (@mode not like 'us%') begin
 		select @id = object_id(@objname)
	 	select @type = o.type from sysobjects o where o.id = @id
		 if (@type = 'V')
			 delete #output60 where id = @id and (action = 224 or action = 26)
 		if (@type = 'U')
	 		delete #output60 where id = @id and action = 224
		 if (@type = 'P' or @type = 'X')
			 delete #output60 where id = @id and action <> 224
 	end
	 set nocount off
	 select p.action, 'column' = col_name(p.id, p.colid), p.uid, 'username' = user_name(p.uid), p.protecttype, o.name, 'owner' = user_name(o.uid), p.id
		  from #output60 p, sysobjects o where o.id = p.id order by p.uid, p.id, p.protecttype
 end
go
/* End sp_MSobjectprivs */


/*********************************************************************************************/
/* Special version of sp_MShelpcolumns to fix the large identity value problem for scripting */
/*********************************************************************************************/
print ''
print 'Creating sp_MShelpcolumns2'
print ''
go
create procedure sp_MShelpcolumns2
@tablename varchar(92), @flags int = 0, @orderby varchar(10) = null, @flags2 int = 0
as
	if @flags is null
		select @flags = 0
	if (@tablename = '?')
	begin
		print ''
		print 'Usage:  sp_MShelpcolumns2 @tablename, @flags int = 0'
		print ' where @flags is a bitmask of:'
		print ' 0x0200		= No DRI (ignore Checks, Primary/Foreign/Unique Keys, etc.)'
		print ' 0x0400		= UDDTs --> Base type'
		print ' 0x0800		= 42Syntax (convert numeric/decimal, no identity)'
		print ' 0x80000		= TimestampToBinary (convert timestamp cols to binary(8))'
		print ' 0x40000000	= No Identity attribute'
		return 0
	end

/**********************************/

	declare @objid int, @category int
	select @objid = id, @category = category from sysobjects where id = object_id(@tablename)
	if (@objid is null)
	begin
		RAISERROR (15001, -1, -1, @tablename)
		return 1
	end

	set nocount on

	create table #sphelpcols
	(
		col_name		varchar(30)			NOT NULL,
		col_id			tinyint				NOT NULL,
		col_type		smallint			NOT NULL,
		col_len			tinyint				NOT NULL,
		col_prec		tinyint				NULL,
		col_scale		tinyint				NULL,
		col_numtype		smallint			NOT NULL,	/* For DaVinci to get sp_help-type filtering of prec/scale */
		col_null		bit					NOT NULL,	/* status & 8 */
		col_identity	bit					NOT NULL,	/* status & 128 */
		col_defname		varchar(61)			NULL,		/* fully-qual'd default name, or NULL */
		col_rulname		varchar(61)			NULL,		/* fully-qual'd rule name, or NULL */
		col_basetype	int					NULL,
		col_flags		int					NULL,
		col_seed		numeric (28)					NULL,
		col_increment	int 				NULL,
		col_dridefname	varchar(30)			NULL,		/* DRI DEFAULT name */
		col_drideftext	varchar(255)		NULL,		/* DRI DEFAULT text */
		col_dridefid	int					NULL,		/* subselect hackaround */
	)

	/* First load stuff so we can blot off inappropriate info and massage as per @flags */
	insert #sphelpcols
		select c.name, c.colid, c.usertype, c.length, c.prec, c.scale,
				-- col_numtype for DaVinci:  use sp_help-type prec/scale filtering for @flags2 & 1
			case when (@flags2 & 1 <> 0 and c.type in (38,48,52,55,56,59,60,62,63,106,108,109,110,122)) then 1 else 0 end,
				-- Nullable
			convert(bit, c.status & 0x0008),
				-- Identity
			case when (@flags & 0x40000000 = 0) then convert(bit, c.status & 0x0080) else 0 end,
				-- Non-DRI Default (make sure it's not a DRI constraint).
			case when (c.cdefault = 0) then null when (d.category & 0x0800 <> 0) then null else user_name(d.uid) + '.' + d.name end,
				-- Non-DRI Rule
			case when (c.domain = 0) then null else user_name(r.uid) + '.' + r.name end,
				-- Physical base datatype
			case when (c.usertype < 100) then c.usertype else bt.usertype end,
				-- Initialize flags to whether it's a length-specifiable type, or a numeric type, or 0.
			case when c.usertype in (1, 2, 3, 4) then 0x0001 when c.usertype in (10, 24, 25, 26) then 0x0002 else 0 end,
				-- Identity seed and increment
			case when (c.status & 0x0080 = 0) then null else ident_seed(@tablename) end,
			case when (c.status & 0x0080 = 0) then null else ident_incr(@tablename) end,
				-- DRI Default name
			case when (@flags & 0x0200 = 0 and d.category & 0x0800 <> 0) then object_name(c.cdefault) else null end,
				-- DRI Default text, if it does not span multiple rows (if it does, SQLOLE will go get them all).
			case when (@flags & 0x0200 = 0 and d.category & 0x0800 <> 0)
					then t.text else null end,
				-- Hackaround for a subselect bug
			c.cdefault
		from syscolumns c, sysobjects d, sysobjects r, systypes bt, syscomments t
		where c.id = object_id(@tablename)
				-- NonDRI Default and Rule filters
			and d.id =* c.cdefault and r.id =* c.domain
				-- Physical base type
			and bt.type =* c.type and bt.usertype < 99 and bt.usertype not in (18, 80)
				-- DRIDefault text, if it's only one row.
			and t.id =* c.cdefault and t.colid = 1

	/* Could not do this on the fly as the subselect is not properly processed. */
	/* An "and not exists" fails on 6.0 due to parser bug so this is the only way to make both work. */
	if (@flags & 0x0200 = 0)
		update #sphelpcols set col_drideftext = NULL
			where col_dridefid is not NULL
			and exists (select * from syscomments where id = col_dridefid and colid = 2)

	/* Convert any timestamp column to binary(8) if they asked. */
	if (@flags & 0x80000 != 0)
		update #sphelpcols set col_type = 3, col_len = 8, col_flags = col_flags | 0x0001 where col_type = 80

	/* Convert from the dblib-specific 'nullable' type to something people and the server recognize. */
	update #sphelpcols set col_type = case col_type
			when 15 then 12	/* datetime --> datetimn */
			when 26 then 24	/* decimal --> decimaln */
			when 14 then 8	/* float --> floatn */
			when 13 then 7	/* int --> intn*/
			when 17 then 11	/* money --> moneyn*/
			when 25 then 10	/* numeric --> numericn */
			else col_type end,
		col_basetype = case col_basetype
			when 15 then 12	/* datetime --> datetimn */
			when 26 then 24	/* decimal --> decimaln */
			when 14 then 8	/* float --> floatn */
			when 13 then 7	/* int --> intn*/
			when 17 then 11	/* money --> moneyn*/
			when 25 then 10	/* numeric --> numericn */
			else col_basetype end

	/* Now see what our flags are, if anything.  Ignore the physical base type here -- these */
	/* flags are just for scripting, which doesn't use that. */
	if (@flags is not null and @flags != 0)
	begin
		if (@flags & 0x0400 != 0)
		begin
			/* Track from usertype --> b.<base>type --> u.usertype in systypes */
			update #sphelpcols set col_type = u.usertype,
				-- ReInitialize flags to whether it's a length-specifiable type, or a numeric type, or 0.
				col_flags = case when u.usertype in (1, 2, 3, 4) then 0x0001 when u.usertype in (10, 24) then 0x0002 else 0 end
			 from #sphelpcols c, systypes b, systypes u
			where c.col_type > 100 and b.usertype = c.col_type and b.type = u.type and u.usertype < 100 and u.usertype not in (18, 80)
		end
		/* Modifided to allow Identity if NoDRI.  This is like a new datatype; OK unless 42Syntax is specified. */
		if (@flags & 0x0800 != 0)
		begin
			update #sphelpcols				/* No IDENTITY */
				set col_identity = 0
			update #sphelpcols				/* Convert numeric and decimal with prec < 8 to real */
				set col_type = 23 where col_type in (10, 24) and col_prec < 8
			update #sphelpcols				/* Convert numeric and decimal with prec >= 8 to float */
				set col_type = 8 where col_type in (10, 24)	and col_prec >= 8
		end
	end

	/* Determine if the column is in the primary key */
	if (@flags & 0x0200 = 0 and @category & 0x200 <> 0) begin
		declare @indid int
		select @indid = indid from sysindexes i where i.id = @objid and i.status & 0x0800 <> 0

		/* There can't be more columns in an index than there are in a table, so use the col_id's */
		/* to form a numeric sequence to query the index_col ordinals.  Note that this does NOT */
		/* imply a relationship between the col_id and the name returned for it; in fact they will */
		/* not be the same unless the first x columns are the index columns, in order.  col_id is */
		/* ONLY used to form an unbroken numeric sequence to query index_col; the #sphelpcols */
		/* update by name is a separate step. */
		if (@indid is not null)
			update #sphelpcols set col_flags = col_flags | 0x0004 where col_name in
				(select index_col(@tablename, @indid, col_id) from #sphelpcols where col_id <= 16)
	end

	/* OK, now put out the data.  @flags2 added for DaVinci; currently only bit 1 (sp_help filtering of prec/scale) is relevant. */
	set nocount off
	if (@orderby is null or @orderby = 'id')
	begin
		select c.col_name, c.col_id, DataType = t.name, c.col_len,
					-- Prec/scale only for numeric/decimal
				col_prec = case when (col_basetype in (10, 24) or (@flags2 & 1 <> 0 and col_numtype & 1 <> 0))
						then c.col_prec else NULL end,
				col_scale = case when (col_basetype in (10, 24) or (@flags2 & 1 <> 0 and col_numtype & 1 <> 0))
						then c.col_scale else NULL end,
				BaseType = b.name, c.col_defname, c.col_rulname, c.col_null, c.col_identity,
				c.col_flags, c.col_seed, c.col_increment, c.col_dridefname, c.col_drideftext
		from #sphelpcols c, systypes t, systypes b
		where t.usertype = c.col_type and b.usertype = c.col_basetype
		order by c.col_id
	end else begin
		select c.col_name, c.col_id, DataType = t.name, c.col_len,
					-- Prec/scale only for numeric/decimal
				col_prec = case when (col_basetype in (10, 24) or (@flags2 & 1 <> 0 and col_numtype & 1 <> 0))
						then c.col_prec else NULL end,
				col_scale = case when (col_basetype in (10, 24) or (@flags2 & 1 <> 0 and col_numtype & 1 <> 0))
						then c.col_scale else NULL end,
				BaseType = b.name, c.col_defname, c.col_rulname, c.col_null, c.col_identity,
				c.col_flags, c.col_seed, c.col_increment, c.col_dridefname, c.col_drideftext
		from #sphelpcols c, systypes t, systypes b
		where t.usertype = c.col_type and b.usertype = c.col_basetype
		order by c.col_name
	end

go
/* End sp_MShelpcolumns2 */


/********************* Grant privileges *********************************/
print ''
print 'Granting execute permissions on procedures'

grant execute on sp_MShelpcolumns to public
grant execute on sp_MSdependencies to public
grant execute on sp_MSobjectprivs to public
grant execute on sp_MShelpcolumns2 to public
go


/********************** Verify object creation and update category bit for objects *********************************/
print ''
print 'Updating category for objects created by msdep65.sql.'
print ''
go

sp_configure 'allow updates', 1
go
reconfigure with override
go

/* New validation added for 6.5 */
if (@@microsoftversion >= 0x000632c0) begin
	exec sp_MS_upd_sysobj_category 2
end else begin
	update sysobjects set category = category | 2
		where sysstat & 0x0f = 0x0002 and name in (
			'sp_MShelpcolumns',
			'sp_MSdependencies',
			'sp_MSobjectprivs',
			'sp_MShelpcolumns2'
		)
end
go

sp_configure 'allow updates', 0
go
reconfigure with override
go


