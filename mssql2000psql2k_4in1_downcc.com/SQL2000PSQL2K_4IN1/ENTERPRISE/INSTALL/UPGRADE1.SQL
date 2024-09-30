
/*
** Upgrade1.CQL  --- 1996/08/29 12:44
**
** (Sphinx/7.0 version, very different from Hydra/6.5 version.)
** Copyright Microsoft, Inc. 1994 - 2000
** All Rights Reserved.
*/

/*********************************
	This Hydra/6.5 file serves no major purpose in Sphinx/7.0,
except to create sp_MS_upd_sysobj_category early enough.
*********************************/
go

use master
set nocount on

go

backup tran master with no_log
go

if (not (is_srvrolemember('sysadmin') = 1))
   raiserror('Aborting, because only the SA can run this script! (1)',16,127) with log
go

---------------------------- sp_MS_marksystemobject -----------------------------

if object_id('sp_MS_marksystemobject', 'P') IS NOT NULL
    drop procedure sp_MS_marksystemobject
raiserror('create procedure sp_MS_marksystemobject ...',0,1)
go
-- FOR INTERNAL USE ONLY ... DO NOT DOCUMENT --
-- This procedure sets a bit in sysobjects.  This bit has no meaning, various
--	groups (starfigther, davinci, replication) use it for different things
-- MSQL makes no warranty, express or implied, on what objects will or will
--	not have this bit set.  Use at your own risk.
--   
create procedure sp_MS_marksystemobject
    @objname    nvarchar(517)  -- 517 is max for two part name
as
    -- pre-stuff --
    set nocount on

    -- CHECK PERMISSIONS (MUST BE DBO OR SETUP ADMIN) --
    if (not is_member('db_owner')=1)
    begin
        raiserror('sp_MS_marksystemobject: Must be db_owner',0,1)
        return 1
    end

    -- CHECK THE OBJECT NAME --
    if object_id(@objname, 'local') is null
    begin
        raiserror('sp_MS_marksystemobject: Invalid object name ''%ls''',0,1,@objname)
        return 1
    end

    -- CHECK THE OBJECT OWNER (MUST BE A SYSTEM USER) --
    if user_name(ObjectProperty(object_id(@objname, 'local'), 'ownerid'))
                not in ('dbo','INFORMATION_SCHEMA')
    begin
        raiserror('sp_MS_marksystemobject: Object must be owned by a system user.',0,1)
        return 1
    end

    -- DO THE UPDATE --
    begin tran
    dbcc LockObjectSchema(@objname)
    update sysobjects set status = status | 0xC0000000
                        where id = object_id(@objname, 'local')
    commit tran
    return @@error  -- sp_MS_marksystemobject
go
exec sp_MS_marksystemobject 'sp_MS_marksystemobject'
go
grant execute on sp_MS_marksystemobject to public
go
---------------------------- sp_MS_upd_sysobj_category ----------------------------

if object_id('sp_MS_upd_sysobj_category','P') IS NOT NULL
    drop procedure sp_MS_upd_sysobj_category
raiserror('create procedure sp_MS_upd_sysobj_category ...',0,1)
go
create procedure sp_MS_upd_sysobj_category
    @pSeqMode   integer     -- 1 for on, 2 for off
as
    set nocount	on
    -- CHECK PERMISSIONS (MUST BE DBO OR SETUP ADMIN) --
    if (not is_member('db_owner')=1) and (not is_srvrolemember('setupadmin')=1)
    begin
        raiserror('sp_MS_upd_sysobj_category: Must be db_owner or setupadmin.',0,1)
        return 1
    end

	-- NOTE: THE IMPLEMENTATION (ie. using trace bit 1717) IS *VERY* LIKELY TO CHANGE,
	--	SO DONT EVEN *THINK* ABOUT USING THIS TRACE BIT DIRECTLY!!!
    if @pSeqMode = 1
        --- Undocu trace 1717.  Now MSShipped bit will be set auto at Create time.
        dbcc traceon  (1717)
    else if @pSeqMode = 2
        dbcc traceoff (1717)
    else
        begin
        raiserror('Unrecognized parm value.',11,35)
        end
    return @@error
Go
exec sp_MS_marksystemobject 'sp_MS_upd_sysobj_category'
go

/*******************************************************************************
-------------------------------- sp_hideobject ---------------------------------

if object_id('sp_hideobject', 'P') IS NOT NULL
    drop procedure sp_hideobject
raiserror('create procedure sp_hideobject ...',0,1)
--go
create procedure sp_hideobject
    @objname    nvarchar(517)
as
    -- pre-stuff --
    set nocount on

    -- CHECK PERMISSIONS (MUST BE DBO OR SETUP ADMIN) --
    if (not is_member('db_owner')=1) and (not is_srvrolemember('setupadmin')=1)
    begin
        raiserror('sp_hideobject: Must be db_owner or setupadmin.',0,1)
        return 1
    end

    -- CHECK THE OBJECT NAME --
	declare @objid int
	select @objid = object_id(@objname, 'local')
	if @objid is null
    begin
        raiserror('sp_hideobject: Invalid object name ''%s''',0,1,@objname)
        return 1
    end

    -- CHECK THE OBJECT OWNER (MUST BE A SYSTEM USER) --
    if user_name(ObjectProperty(@objid, 'ownerid')) not in ('dbo','INFORMATION_SCHEMA')
    begin
        raiserror('sp_hideobject: Object must be owned by a system user.',0,1)
        return 1
    end

    -- DO THE UPDATE --
    begin tran
    dbcc LockObjectSchema(@objname)
    update sysobjects set status = status | 0x40000000 where id = @objid
    commit tran
    return @@error  -- sp_hideobject
--go
exec sp_MS_marksystemobject 'sp_hideobject'
--go
grant execute on sp_hideobject to public
--go
********************************************************************************/

---------------------------- sp_db_upgrade ----------------------------

if object_id('sp_db_upgrade','P') IS NOT NULL
	drop procedure sp_db_upgrade
raiserror('create procedure sp_db_upgrade',0,1)
Go
create procedure sp_db_upgrade
	@dbname varchar (255) = NULL
as
	declare @currentDb varchar (255)

	if @dbname is null
		select @currentDb = db_name ()
	else
		select @currentDb = @dbname

	dbcc upgradedb (@currentDb)
    
	return 0
Go
exec sp_MS_marksystemobject 'sp_db_upgrade'
go

-- Add xp_regread if necessary.

if object_id('xp_regread') IS NULL
	begin
	raiserror('(addextendedproc a1)',0,1)
	dbcc addextendedproc( 'xp_regread', 'xpstar.dll')
	exec sp_MS_marksystemobject 'xp_regread'
	end
go


backup Transaction master with no_log
Go
Checkpoint
Go

declare @vc1 varchar(55)
select  @vc1 = convert(varchar,getdate(),113)
raiserror('This file completed successfully at %s' ,0,1 ,@vc1)
go

