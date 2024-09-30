
/*
** setuprepl.sql	
**
**
** Copyright Microsoft, Inc. 1998-2000
** All Rights Reserved.
*/

go
use master
go
dump tran master with no_log
go
set nocount on
go

exec sp_MS_upd_sysobj_category 1 --Capture time for use at the end
go

if exists (select * from sysobjects
		where sysstat & 0xf = 4
			and name = 'sp_helpdistributor')
	drop procedure sp_helpdistributor
go

if exists (select * from sysobjects
		where sysstat & 0xf = 4
			and name = 'sp_helpdistributiondb')
	drop procedure sp_helpdistributiondb
go

if exists (select * from sysobjects
		where sysstat & 0xf = 4
			and name = 'sp_helpdistpublisher')
	drop procedure sp_helpdistpublisher
go

if exists (select * from sysobjects
		where sysstat & 0xf = 4
			and name = 'sp_helpsubscriberinfo')
	drop procedure sp_helpsubscriberinfo
go

if exists (select * from sysobjects
		where sysstat & 0xf = 4
			and name = 'sp_helpreplicationdboption')
	drop procedure sp_helpreplicationdboption

if exists (select * from sysobjects 
		where name = 'sp_get_distributor' 
				and type = 'P')
	  drop procedure sp_get_distributor
go

print ''
print 'Creating proxy procedure sp_heldistributor'
go
CREATE PROCEDURE sp_helpdistributor (
	@distributor varchar(30)  = '%' OUTPUT, /* The distribution server name */
	@distribdb   varchar(30)  = '%' OUTPUT, /* The distribution database script */
        @directory   varchar(255) = '%' OUTPUT, /* The working directory */
        @account     varchar(255) = '%' OUTPUT, /* The Windows NT user account */
	@local varchar(5) = NULL		/* Get local server values */
        ) AS

    /*
    ** Declarations.
    */
	DECLARE @loc_distributor varchar(30)
	DECLARE @loc_distribdb 			varchar(30)
    DECLARE @loc_directory 			varchar(255)
    DECLARE @loc_account 			varchar(255)
	DECLARE @mindistretention 	int
	DECLARE @maxdistretention 	int
	DECLARE @historyretention   int  
	DECLARE @historycleanuptask varchar(30)
	DECLARE @distribcleanuptask varchar(30)
		DECLARE @reg_key varchar (255)
	DECLARE @proc varchar(255)


    SET NOCOUNT ON

	
    /*
    ** If @local flag, get current server's distribution values.
    */
    IF LOWER (@local) = 'local'
	SELECT @loc_distributor = @@SERVERNAME
    /*
    ** Get the distribution server
    */
    ELSE
        BEGIN
	    SELECT @loc_distributor = srvname
	      FROM master..sysservers
	     WHERE srvstatus & 8 <> 0
	
	     IF @@error <> 0
		BEGIN
		    RAISERROR (14071, 16, -1)
		    RETURN (1)
		END
	END

    /*
    ** If remote distribuiton, execute sp_helpdistributor on distribution
    ** server.
    */
    IF UPPER(@loc_distributor) <> UPPER(@@SERVERNAME)
       BEGIN
	    SELECT @proc = RTRIM(@loc_distributor) + '.master..sp_helpdistributor'
            EXECUTE @proc
		@loc_distributor OUTPUT,
		@loc_distribdb OUTPUT,
		@loc_directory OUTPUT,
		@loc_account OUTPUT,
		@local = 'local'
	    IF @@ERROR <> 0
	       RETURN (1)

            GOTO DONE
       END

    /*
    ** Fetch the distribution database name.
    */
    IF (@distributor = '%' AND @distribdb = '%' AND @directory = '%'
	AND @account = '%') OR @distribdb IS NULL
       BEGIN
	    SELECT @proc = 'master..xp_regread'
	    EXECUTE @proc 'HKEY_LOCAL_MACHINE',
			  'SOFTWARE\Microsoft\MSSQLServer\Replication',
			  'DistributionDB',
		    @param = @loc_distribdb OUTPUT
	
	    IF @@ERROR <> 0 RETURN (1)
	END	
    /*
    ** Fetch the distribution working directory.
    */
    IF (@distributor = '%' AND @distribdb = '%' AND @directory = '%'
	AND @account = '%') OR @directory IS NULL
       BEGIN
	    SELECT @proc = 'master..xp_regread'
	    EXECUTE @proc 'HKEY_LOCAL_MACHINE',
			  'SOFTWARE\Microsoft\MSSQLServer\Replication',
			  'WorkingDirectory',
		    @param = @loc_directory OUTPUT
	
	    IF @@ERROR <> 0 RETURN (1)
       END

    /*
    ** Fetch the distribution account name.
    */
    IF (@distributor = '%' AND @distribdb = '%' AND @directory = '%'
	AND @account = '%') OR @account IS NULL
       BEGIN
	    SELECT @proc = 'master..xp_regread'
	    EXECUTE @proc 'HKEY_LOCAL_MACHINE',
			  'SYSTEM\CurrentControlSet\Services\SQLExecutive',
			  'ObjectName',
		    @param = @loc_account OUTPUT
	
	    IF @@ERROR <> 0 RETURN (1)
       END

DONE:

    /*
    ** Return result set if no output parameters
    */

    IF @distributor = '%' AND @distribdb = '%' AND @directory = '%'
	AND @account = '%'

	SELECT 'distributor'           = @loc_distributor,
               'distribution database' = @loc_distribdb,
               'directory'             = @loc_directory,
               'account'               = @loc_account,
               'min distrib retention' = @mindistretention,
               'max distrib retention' = @maxdistretention,
               'history retention'     = @historyretention,
               'history cleanup task'  = @historycleanuptask,
               'distribution cleanup task' = @distribcleanuptask
 
    /*
    ** Return output parameters if requested.
    */

    IF @distributor IS NULL
    	SELECT @distributor = @loc_distributor
    IF @distribdb IS NULL
    	SELECT @distribdb = @loc_distribdb
    IF @directory IS NULL
    	SELECT @directory = @loc_directory
    IF @account IS NULL
	SELECT @account = @loc_account

    RETURN (0)
go


print ''
print 'Creating proxy procedure sp_helpdistributiondb'
GO
CREATE PROCEDURE sp_helpdistributiondb
 AS

	SET NOCOUNT ON

	DECLARE @distributiondb varchar(30)
	DECLARE @min_distretention int
	DECLARE @max_distretention int
	DECLARE @history_retention int
	DECLARE @reg_key varchar(255)
	DECLARE @history_cleanup_task varchar(100) 
	DECLARE @distributor_cleanup_task varchar(100)
	DECLARE @status int
    
	SELECT @max_distretention = 9999
	SELECT @min_distretention = 0
	SELECT @history_retention = 24

	/*
    ** Return empty result set if not a distributor
    */
    IF NOT EXISTS (SELECT * FROM master..sysservers
              WHERE UPPER(srvname) = UPPER(@@SERVERNAME)
                 AND srvstatus & 8 <> 0)
	BEGIN
		GOTO DONE
	END

	/*
    ** Fetch the distribution database
    */	
	SELECT @reg_key =  'SOFTWARE\Microsoft\MSSQLServer\Replication'
	EXECUTE master..xp_regread 'HKEY_LOCAL_MACHINE',
		  @reg_key,
		  'DistributionDB',
		@param = @distributiondb OUTPUT


DONE:
	SELECT		'distribution_database'	= @distributiondb,
				'min_distretention'		= @min_distretention,
				'max_distretention'		= @max_distretention,
				'history_retention'		= @history_retention,
				'history_cleanup_task'	= @history_cleanup_task,
				'distributor_cleanup_task'	= @distributor_cleanup_task,
				'status' = @status,
				'data_folder' = convert(varchar(255), NULL),
				'data_file' = convert(varchar(255), NULL),
				'data_file_size' = convert(int, 16),
				'log_folder' = convert(varchar(255), NULL),
				'log_file' = convert(varchar(255), NULL),
				'log_file_size' = convert(int, 16)
			where @distributiondb is not null
	GO

print ''
print 'Creating proxy procedure sp_helpdistpublisher'
GO
CREATE PROCEDURE sp_helpdistpublisher 
AS

	SET NOCOUNT ON

	DECLARE @distributor varchar(30)
	DECLARE @distributiondb varchar(30)
    DECLARE @retcode int
	DECLARE @distpublisher varchar(30)
	DECLARE @security_mode int
	DECLARE @standard_login varchar(30)
	DEClARE @standard_password varchar(30)
	DECLARE @reg_key varchar(255)
	DECLARE @publisher_active bit
	DECLARE @proc varchar(255)
	DECLARE @loc_directory varchar(255)
	declare @true bit
	declare @false bit

	select @true = 1
	select @false = 0

	/*
    ** Return empty result set if not a distributor
    */
    IF NOT EXISTS (SELECT * FROM master..sysservers
              WHERE UPPER(srvname) = UPPER(@@SERVERNAME)
                 AND srvstatus & 8 <> 0)
	BEGIN
		SELECT 'distributor_publisher' = @distributor,
			'distributor_database' = @distributiondb,
			'security_mode' = @security_mode,
			'standard_login' = @standard_login,
			'standard_password' = @standard_password,
			'publisher_active' = @publisher_active,
			'working_directory' = @loc_directory
		RETURN 
	END

	SELECT @security_mode = 1
	
	SELECT @proc = 'master..xp_regread'
	EXECUTE @proc 'HKEY_LOCAL_MACHINE',
		  'SOFTWARE\Microsoft\MSSQLServer\Replication',
		  'WorkingDirectory',
		@param = @loc_directory OUTPUT

	IF @@ERROR <> 0 RETURN (1)

	/*
    ** Fetch the distribution database
    */	
	SELECT @reg_key =  'SOFTWARE\Microsoft\MSSQLServer\Replication'
	EXECUTE master..xp_regread 'HKEY_LOCAL_MACHINE',
		  @reg_key,
		  'DistributionDB',
		@param = @distributiondb OUTPUT

	SELECT 'distributor_publisher' = srvname,
			'distributiondb' = @distributiondb,
			'security_mode' = @security_mode,
			'standard_login' = @standard_login,
			'standard_password' = @standard_password,
			'publisher_active' = @publisher_active,
			'working_directory' = @loc_directory,
			'trusted' = case when UPPER(srvname) = UPPER(@@SERVERNAME) then @false else @true end,
			'thirdparty_flag' = @false 
			FROM master..sysservers WHERE (srvstatus & 16 <> 0) OR UPPER(srvname) = UPPER(@@SERVERNAME)

GO

print ''
print 'Creating proxy procedure sp_helpsubscriberinfo'
go

CREATE PROCEDURE sp_helpsubscriberinfo
	@subscriber varchar (30) = '%'
    AS

    SET NOCOUNT ON

    DECLARE @distributor varchar(30)
    DECLARE @distribdb varchar(30)
    DECLARE @distproc varchar (255)
    DECLARE @retcode int
    DECLARE @subscriber_bit smallint

    /*
    ** Initializations.
    */
    SELECT @subscriber_bit = 4

    /*
    ** Check if subscriber is valid
    */

    IF @subscriber IS NULL
        BEGIN
            RAISERROR (14043, 16, -1, '@subscriber')
            RETURN (1)
        END


    IF @subscriber <> '%'
        BEGIN

            EXECUTE @retcode = sp_validname @subscriber
            IF @retcode <> 0
                RETURN (1)

	        IF NOT EXISTS (SELECT *
                        FROM master..sysservers
                        WHERE UPPER(srvname) = UPPER(@subscriber)
                        AND (srvstatus & @subscriber_bit) <> 0)
                BEGIN
                    RAISERROR (14010, 16, -1)
                    RETURN (1)
                END
        END


    /*
    ** Get distribution server information for remote RPC
    ** subscription calls.
    */
	EXEC @retcode = sp_helpdistributor @distributor = @distributor OUTPUT,
                                       @distribdb   = @distribdb OUTPUT

	/* RAISEERROR is subscriber is not '%' */		                                       
    IF @@error <> 0 OR @retcode <> 0 OR @distribdb IS NULL OR @distributor IS NULL
    	BEGIN
	    IF @subscriber <> '%'
    	    BEGIN
    	    	RAISERROR (14071, 16, -1)
        		RETURN (1)
			END
		ELSE
			RETURN 0
		END

    /*
    ** Retrieve MSsubscriber_info
    */
	if UPPER(@distributor) = UPPER(@@SERVERNAME)
	  EXEC ('select *, 1 from ' + @distribdb + '..MSsubscriber_info where publisher = ''' 
	     + @@SERVERNAME + ''' and UPPER(subscriber) like UPPER(''' + @subscriber + ''')')
	else
	   begin
		SELECT @distproc = RTRIM(@distributor) + '.' +
			RTRIM(@distribdb) + '..sp_MShelp_subscriber_info'

		EXEC @retcode = @distproc @@SERVERNAME, @subscriber

		IF @@error <> 0
			BEGIN
			RAISERROR (14071, 16, -1)
			RETURN (1)
		END

		IF @retcode <> 0
			BEGIN
			RAISERROR (14085, 16, -1)
			RETURN (1)
		 END
	   end
go

print ''
print 'Creating proxy procedure sp_helpreplicationdboption'
go

CREATE PROCEDURE sp_helpreplicationdboption
        @dbname varchar (30) = '%', @type varchar(30) = 'replication allowed'
    AS

    SET NOCOUNT ON

    /*
    ** Declarations.
    */

    DECLARE @retcode int, @typebit int
    
    /* bit to distinguish distribution databases */
    DECLARE @distbit int
    SELECT @distbit = 16

	DECLARE @dbowner bit
	
	select @dbowner = 1

	DECLARE @dbreadonly bit
	SELECT @dbreadonly = 0
		
    if (lower(@type) like 'publish%')
       select @typebit = 1
    else if (lower(@type) like 'subscribe%')
       select @typebit = 2
    else if (lower(@type) like 'merge publish%')
       select @typebit = 4
    else if (lower(@type) like 'merge subscribe%')
       select @typebit = 8
    else if (lower(@type) like 'replication allowed%')
        select @typebit = 0
    else        
        begin
            raiserror(14091,-1,-1)
            return 1
        end

    /*
    ** Parameter Check:  @dbname.
    ** Check to make sure that the database name conforms to the rules
    ** for identifiers.
    */

    IF @dbname <> '%'
       BEGIN
          EXECUTE @retcode = sp_validname @dbname

          IF @@ERROR <> 0 OR @retcode <> 0
			RETURN (1)
       END

    /*
    ** Show databases with this option enabled.
    */
    CREATE TABLE #replicationdbs (name varchar(30), id int identity, transpublish bit not null, mergepublish bit not null, dbowner bit not null, dbreadonly bit not null)
    if @typebit <> 0
        begin
            INSERT INTO #replicationdbs  (name, transpublish, mergepublish, dbowner, dbreadonly)
                SELECT name, 
				case when (category & 1) <> 0 then 1 else 0 end,
				case when (category & 4) <> 0 then 1 else 0 end,
				@dbowner,
				@dbreadonly
                FROM sysdatabases
                WHERE ((@dbname = '%') or (name = @dbname)) 
                AND (category & @typebit) <> 0
        end            
    else
        begin
            DECLARE @replication_db varchar(30)
			DECLARE @db_category int

            /* Filter out distribution databases */
            DECLARE hC SCROLL CURSOR FOR 
                SELECT name, category FROM master..sysdatabases WHERE ((@dbname = '%') or (name = @dbname)) 
                    AND (category & @distbit) = 0
            OPEN hC
            FETCH hC INTO @replication_db, @db_category
            WHILE (@@fetch_status <> -1)
                BEGIN
                    if @replication_db <> 'master' AND @replication_db <> 'model'
                        AND @replication_db <> 'tempdb' AND @replication_db <> 'msdb'
                    INSERT INTO #replicationdbs (name, transpublish, mergepublish, dbowner, dbreadonly) VALUES (@replication_db,
						case when (@db_category & 1) <> 0 then 1 else 0 end,
						case when (@db_category & 4) <> 0 then 1 else 0 end,
						@dbowner, @dbreadonly)
                    FETCH hC INTO @replication_db, @db_category
                END

            CLOSE hC
            DEALLOCATE hC
        end
        SELECT * FROM #replicationdbs
        DROP TABLE #replicationdbs
go


print ''
print 'Creating proxy procedure sp_get_distributor'
go

-- Called by the UI to find out if the distributor is installed without doing RPC.
CREATE PROCEDURE sp_get_distributor 
AS
     SET NOCOUNT ON

    /*
    ** Declarations.
    */
    DECLARE @distributor sysname
	DECLARE @installed bit
	declare @distdb_installed bit
	declare @is_distpublisher bit
	declare @has_remote_distpublisher bit
 	declare @distbit int

	SELECT @distbit = 16
       
	SELECT @distributor = srvname FROM master..sysservers
		WHERE srvstatus & 8 <> 0

	if @distributor is not null
		select @installed = 1
	else
		select @installed = 0

	if UPPER(@distributor) = UPPER(@@servername)
	begin
		select @distdb_installed = 1
		select @is_distpublisher = 1
		select @has_remote_distpublisher = 1
	end
	else
	begin
		select @distdb_installed = 0
		select @has_remote_distpublisher = 0	
		select @is_distpublisher = 0
	end

	select 'installed' = @installed, 'distribution server' = @distributor,
			'distribution db installed' = @distdb_installed,
			'is distribution publisher' = @is_distpublisher,
			'has remote dist publisher' = @has_remote_distpublisher
GO

exec sp_MS_upd_sysobj_category 2  --set sysobjects.category | 2 based on crdate.
go
