/*
** replp70.sql            1997/02/12 22:03
**
**
** Copyright Microsoft, Inc. 1998-2000
** All Rights Reserved.
*/


dump tran master with no_log
go

exec sp_configure 'update',1
go
reconfigure with override
go

set ANSI_NULLS off
set nocount on
set implicit_transactions off
go

use master
go

if exists (select * from sysobjects
    where type = 'P '
            and name = 'sp_addpublisher70')
    drop procedure sp_addpublisher70
go

print 'Creating stored procedure sp_addpublisher70.'
go

CREATE PROCEDURE sp_addpublisher70 (
	@publisher varchar (30),    /* publisher server name */
	@dist_account varchar(255)  /* dist agent NT account */
        ) AS

    /*
    ** Declarations.
    */

    DECLARE @proc varchar (255)
    DECLARE @retcode int
    DECLARE @privilege varchar (30)

    /*
    ** Parameter Check:  @publisher.
    ** Check to make sure that the publisher is not NULL and that it
    ** conforms to the rules for identifiers.
    */

    IF @publisher IS NULL
        BEGIN
            RAISERROR (14043, 16, -1, '@publisher')
            RETURN (1)
        END

    EXECUTE @retcode = sp_validname @publisher

    IF @@ERROR <> 0 OR @retcode <> 0
	RETURN (1)


    /*
    ** Check to make sure that the publisher doesn't already exist.
    */
    IF EXISTS (SELECT * FROM master..sysservers
              WHERE UPPER(srvname) = UPPER(@publisher)
                 AND srvstatus & 2 <> 0)
	BEGIN
		RAISERROR (14074, 16, -1, @publisher)
		RETURN (1)
	END

    /*
    ** The server may already be listed in master..sysservers, but might
    ** not be marked as a publisher yet.  If it's not in
    ** master..sysservers, let's add it first.
    */

    IF NOT EXISTS (SELECT *
                     FROM master..sysservers
                    WHERE UPPER(srvname) = UPPER(@publisher))

    	BEGIN
    	    EXECUTE @retcode = sp_addserver @publisher
    	    IF @@error <> 0 OR @retcode <> 0
    	        BEGIN
                    RAISERROR (14075, 16, -1)
    	            RETURN (1)
    	        END
    	END

  

    /*
    ** Set the server option to indicate that this is a publisher.
    */
    EXECUTE @retcode = sp_serveroption @publisher, 'pub', true
    IF @@error <> 0 OR @retcode <> 0
        BEGIN
            RAISERROR (14075, 16, -1)
            RETURN (1)
        END


    /*
    ** Check if @dist_account has admin or repl privilege already.
    */
    EXECUTE @retcode = master.dbo.xp_logininfo @dist_account, 'all',
       @privilege = @privilege output
    IF @@error <> 0 OR @retcode <> 0
        BEGIN
            RAISERROR (14076, 10, -1, @dist_account)
            RETURN (0)
        END

    IF @privilege = 'admin' OR @privilege = 'repl'
       RETURN  (0)

    /*
    ** Grant replication privilege to the distributor NT account.
    */
    EXECUTE @retcode = master.dbo.xp_grantlogin @dist_account, repl
    IF @@error <> 0 OR @retcode <> 0
        BEGIN
            RAISERROR (14076, 10, -1, @dist_account)
            RETURN (0)
        END
go

/*
Created by RHS, 7/20/98

This is a special version of sp_table_validation to be used only on a 6.5x subscriber, and only when the 
distributor is started with the special flag  "-Validate6x" .   It is not possible to do checksum validation for 
6.5 subscribers since the necessary server support is not there.  Hence, rowcount only validation is only done.  
If checksum validation is requested, this proc will return a success if the rowcount method worked, and a failure if 
rowcount did not.   But the message will make it clear the checksum is a no-op.  This is done, rather than returning a 
failure, so that sites with both 7.x and 6.5x based subscribers can still ask for checksums, which will be done at the
7.x subscribers.
*/


-- Insist that this is being run by a 6.5x based server.   This is not intended for a 7.0 subscriber.
if (select charindex('6.',@@version)) <= 0 
	raiserror('This script is for 6.x based subscribers only. Exiting...',22,127)
go


---- Make sure server was started in single user mode or that sp_configure was used to enable updates to system tables.

if (select value from syscurconfigs where config = 102) <> 1
	raiserror('Cannot update sysmessages unless updates to system tables are enabled.  Shutdown server and restart with the ''-m'' option or use sp_configure to enable updates to system tables.'
		,22,127) with log
go

---------------------------------  DELETE  -------------------------------------------------------------
DELETE sysmessages
	where error in
	(
	20524,20525,20526,20527,20558,20559,20560,20561,20578,20579
	)
go
	
insert into master..sysmessages (error, severity, dlevel, description)
	values
	(20524,10,0,'Table ''%s'' may be out of synchronization. Rowcount difference (actual: %d, expected: %d). Rowcount method %d used (0 = Full, 1 = Fast).')	
insert into master..sysmessages (error, severity, dlevel, description)
	values
	(20525,10,0,'Table ''%s'' is out of synchronization. Rowcounts (actual: %d, expected %d). Checksum not available for 6.5 based subscribers.')	
insert into master..sysmessages (error, severity, dlevel, description)
	values
	(20526,10,0,'Table ''%s'' passed rowcount (%d) validation. Rowcount method %d used (0 = Full, 1 = Fast).')
insert into master..sysmessages (error, severity, dlevel, description)
	values
	(20527,10,0,'Table ''%s'' passed rowcount (%d) validation. (Note: checksum is not available for 6.5 subscribers)')
insert into master..sysmessages (error, severity, dlevel, description)
	values
	(20558,10,0,'Table ''%s'' passed full rowcount validation after failing the fast check. DBCC UPDATEUSAGE will be automatically initiated.')
insert into master..sysmessages (error, severity, dlevel, description)
	values
	(20559,10,0,'Conditional Fast Rowcount method requested without specifying an expected count. Fast method will be used.')
insert into master..sysmessages (error, severity, dlevel, description)
	values
	(20560,10,0,'An expected checksum value was passed, but checksums will not be compared because rowcount only checking was requested.')
insert into master..sysmessages (error, severity, dlevel, description)
	values
	(20561,10,0,'Generated expected rowcount value of %d for %s.')
insert into master..sysmessages (error, severity, dlevel, description)
	values
	(20578,10,0, 'Replication: Agent custom shutdown.') -- Alert name
insert into master..sysmessages (error, severity, dlevel, description)
	values
	(20579,10,0,'Generated expected rowcount value of %d.  Checksums not valid on 6.5 subscriber.  Dummy checksum value of %s for %s will be used.')
go

if exists (SELECT * FROM sysobjects where name = 'sp_table_validation')
	drop proc sp_table_validation
go


print 'Creating special 6.x version of stored procedure sp_table_validation.'
go

create procedure sp_table_validation
@table sysname,
@expected_rowcount int = NULL OUTPUT,
@expected_checksum numeric = NULL OUTPUT,
@rowcount_only bit = 1,
@owner	sysname = NULL,
@full_or_fast tinyint = 2,	-- full (value 0) does COUNT(*) 
				-- fast (value 1) uses sysindexes.rows if table (not view); 
				-- conditional fast (VALUE 2) , first tries fast method, but
				-- reverts to full if fast method shows differences.
@shutdown_agent bit = 0	 	-- If 1 will raise error 20578, which will signal replication agent to shutdown

as

set nocount on

declare @num_rows int
declare @checksum numeric
declare @checksum_string varchar(100)
declare @expected_checksum_string varchar(100)
declare @width int
-- for special 6.5 version, the following cannot be Nvarchar.
declare @qualified_table_name varchar(80)  -- two names plus []'s and a .
declare @temp_table_used bit
declare @retstatus int
declare @failed_fast tinyint
declare @min_indid int
declare @asked_for_exp_checksum tinyint
declare @asked_for_exp_rows tinyint

if (select charindex('6.5',@@version)) <= 0 
	BEGIN
	raiserror('This script is for 6.5 based subscribers only. Exiting...',22,-1)
	RETURN(-65)
	END

SELECT @retstatus=0	-- initialize to SUCCESS
SELECT @failed_fast=0

if (@expected_checksum IS NULL AND @rowcount_only = 0 )  -- Wants an expected checksum value
	SELECT @asked_for_exp_checksum=1
ELSE
	SELECT @asked_for_exp_checksum=0


if (@expected_rowcount IS NULL)  -- Wants an expected checksum value
	SELECT @asked_for_exp_rows=1
ELSE
	SELECT @asked_for_exp_rows=0

if (@full_or_fast = 2 AND @expected_rowcount IS NULL)
	BEGIN
	-- Msg 20559,'Conditional Fast Rowcount method requested without specifying an expected count.  Fast method will be used.'
	raiserror (20559, 10, -1)
	SELECT @full_or_fast = 1
	END

-- Another state that doesn't make sense is to pass an expected checksum value, yet
-- ask for rowcount only validation
if (@expected_checksum IS NOT NULL AND @rowcount_only > 0)
	BEGIN
	-- Msg 20560,'An expected checksum value was passed, but checksums will not be compared because Rowcount only checking was requested.'
	raiserror (20560, 10, -1)
	SELECT @expected_checksum = NULL
	END

	
if @owner is null
	select @qualified_table_name = @table
else
	select @qualified_table_name = @owner + '.' + @table 

-- If the object is a table (not view) and fast checking (1) requested,
-- then get rowcount from sysindexes, rather than scanning
IF (SELECT @full_or_fast) > 0    -- IF Fast row checking asked for
	BEGIN
		-- Do the fast rowcount method
		-- Temporarily put a SHARE lock on table to ensure no simultaneous updates going on
		-- Minimizes chances of getting an out of date value from sysindexes.   True that
		-- it reduces concurrency, but if the fast method doesnt work the user will very likely
		-- go do the full method, which will be much more costly.   Better I think to take a little more cost here
		-- and hopefully get a good number.   The @foo variable is used so that its an
		-- assignment and doesn't make another result set get returned.

		BEGIN TRAN
		EXEC ('DECLARE @foo int SELECT @foo=1 FROM ' + @qualified_table_name + ' (TABLOCK HOLDLOCK) WHERE 1=2')
		SELECT @num_rows=rows,@min_indid=indid FROM sysindexes WHERE id=OBJECT_ID(@qualified_table_name)and indid < 2
		COMMIT TRAN
	END

ELSE 
	BEGIN
		SELECT @full_or_fast = 0   -- Full checking will be used, regardless of whether it was requested
	END

-- If fast row checking was used, and request for rowcount check only, we're done.
if (@full_or_fast = 1  AND  @rowcount_only > 0) 
	BEGIN
		GOTO ROWCOUNT_MSG
	END

-- If conditional fast row checking was used, and request for rowcount check only, 
-- we're also done IFF rows and expected rows match.
if (@full_or_fast = 2  AND  @rowcount_only > 0 
	AND @expected_rowcount IS NOT NULL AND @expected_rowcount=@num_rows)
	BEGIN
		-- Fast checking was actually used.
		-- if @debug=1 PRINT "conditional fast rowcount requested & passed - going to rowcount msg"
		SELECT @full_or_fast = 1
		GOTO ROWCOUNT_MSG
	END


-- If we're still here we are doing full row checking at a minimum, and will need the temp table
IF (SELECT ISNULL(OBJECT_ID('tempdb..#tab_validt1'),0)) = 0    -- Table Does Not exist
	CREATE TABLE #tab_validt1 (tmp_rows int NULL, tmp_checksum numeric NULL)
ELSE -- table already exists 
	TRUNCATE TABLE #tab_validt1

-- If we are only doing row checking, we'll do it here.  If we will do both row checking 
-- and checksum, then do them together so as to not scan table twice.
if @rowcount_only = 1
	BEGIN   -- Must do full count(*) checking but not checksums
	if @full_or_fast=2   
		-- if we are here with conditional check (2) requested, it is because
		-- a conditional was possible, but it failed.  We wiil later alert user of this.
		BEGIN 
		SELECT @full_or_fast=0
		SELECT @failed_fast=1
		END
	
	insert into #tab_validt1 (tmp_rows,tmp_checksum) 
		exec ('select count(*), NULL from ' +	@qualified_table_name + ' (TABLOCK HOLDLOCK)')

	-- Get row count value
	-- TOP 1 not legal in 6.5.   There shouldn't be more than one row.  But if there is, raiserror and exit.
	select @num_rows = tmp_rows from #tab_validt1   -- Should only be one row
		if (SELECT @@ROWCOUNT) > 1
			BEGIN
			raiserror('#tab_validt unexpectedly had more than one row.  Error in Proc...',22,-1)
			RETURN(1)
			END
			
	-- IF there were no rows from above, the table was empty so use ZERO.
	IF @num_rows IS NULL
		SELECT @num_rows=0

	-- Done with the temp table
	DROP TABLE #tab_validt1
	
	IF @expected_rowcount IS NULL
		BEGIN
		SELECT @expected_rowcount = @num_rows
		END
	GOTO ROWCOUNT_MSG
	END -- Done with full row count only

ELSE  -- Doing checksums in addition to ROWCOUNT
	BEGIN	-- DO checksum and rowcount in same pass thru the table
	-- In 6.5, the checksum routines are basically NO-OP'd.   A value -99999999 will be reported, but success returned.
	insert into #tab_validt1 (tmp_rows,tmp_checksum)
		exec ('select count(*), -99999999 from ' + @qualified_table_name + ' (TABLOCK HOLDLOCK)')

	-- Get the checksum & rowcount values
	select @checksum = tmp_checksum, @num_rows= tmp_rows from #tab_validt1

	-- IF there were no rows from above, the table was empty so use ZERO.
	IF @checksum IS NULL or @num_rows IS NULL
		SELECT @checksum=isnull(@checksum,0),@num_rows=isnull(@checksum,0)

	-- Done with the temp table
	DROP TABLE #tab_validt1
	
	IF @expected_rowcount IS NULL  -- Just getting value - no expected value yet.
		SELECT @expected_rowcount = @num_rows
	
	-- Validate checksum
	IF @expected_checksum is null		-- Just getting value - no expected value yet.
		SELECT @expected_checksum = @checksum
	else
		-- Raise error if rowcounts do not match
		-- Comment out checksum check - it will report as passing for a 6.5 subscriber.
		if /* @checksum <> @expected_checksum OR */ @num_rows <> @expected_rowcount
			begin
			-- Checksum failed.
			SELECT @checksum_string = convert(varchar(21), @checksum)
			SELECT @expected_checksum_string = convert(varchar(21), @expected_checksum)
			-- Msg 20525: 'Table ''%s'' is out of synchronization. Rowcounts (actual: %d, expected %d). Checksum's not available for 6.5 based subscribers.')	
			raiserror (20525, 10, -1, @table, @num_rows, @expected_rowcount) with log
			SELECT @retstatus=1
			END
		else
		BEGIN
		-- Row count and checksum validation passed.
		-- 
		if @asked_for_exp_checksum=0 -- Only give message if not generating the expected value
		-- Msg 20527: 'Table ''%s'' passed rowcount (%d) validation. (Note: checksum is not available for 6.5 subscribers)'
			raiserror (20527, 10, -1, @table,@num_rows)
		END
	-- Done with checksum and rowcount scan.
	END
-- We did checksum method, and so are done and skip over the rowcount only messages.
GOTO ALL_DONE

ROWCOUNT_MSG:
-- Raise error if rows counts do not match
	IF @expected_rowcount IS NULL  -- just return the found value
		SELECT @expected_rowcount=@num_rows
	ELSE
		IF @num_rows <> @expected_rowcount
		begin
	   
			-- Msg 20524:  'Table ''%s'' may be out of synchronization. 
			-- Row count difference encountered (actual: %d, expected: %d). Row count method %d used.  (0=Full  1=Fast)', NULL)
			raiserror (20524, 10, -1, @qualified_table_name, @num_rows, @expected_rowcount, @full_or_fast ) with log
			SELECT @retstatus=1
		end
		ELSE	-- Row count validation passed. 
		begin

			if @asked_for_exp_rows=0 -- Only give message if not generating the expected value
		      	-- Msg 20526:  'Table ''%s'' passed row count (%d) validation.  Row count method %d used. (0=Full  1=Fast)''
			raiserror (20526, 10, -1, @qualified_table_name, @num_rows, @full_or_fast)
			
			if @failed_fast=1
			BEGIN
			-- if we had to revert to FULL on a CONDITIONAL FAST, Make that known too.
			-- And Update usage to fix the problem
			-- Msg 20558: 'Table ''%s'' passed full row count validation after failing the fast check. 
			-- DBCC UPDATEUSAGE will be automatically initiated.'
			raiserror (20558, 10, -1, @table) with log
			DBCC UPDATEUSAGE (0,@qualified_table_name,@min_indid) WITH COUNT_ROWS, NO_INFOMSGS
			END
		end

ALL_DONE:

-- Give nice message if only generating the expected value:

-- Msg for rows and checksum:
if @asked_for_exp_checksum=1 and @asked_for_exp_rows=1 -- Only give message if generating the expected value
       BEGIN
       SELECT @expected_checksum_string = convert(varchar(21), @expected_checksum)
       -- Msg 20579: 'Generated expected rowcount value of %d.  Checksums not valid on 6.5 subscribr.  Dummy checksum value of %s for %s.')
       raiserror (20579, 10, -1, @expected_rowcount,@expected_checksum_string,@qualified_table_name)
       END
       
ELSE
	BEGIN
		if @asked_for_exp_checksum=0 and @asked_for_exp_rows=1
		-- Msg 20561:'Generated expected rowcount value of %d for %s .'
		raiserror (20561, 10, -1, @expected_rowcount, @qualified_table_name)
	END
        

-- Raise error that will shutdown replication agents
if @shutdown_agent = 1
	--Msg 20578: 'Shutdown replication agent request.'
	raiserror (20578, 10, -1)
	
return @retstatus

go
