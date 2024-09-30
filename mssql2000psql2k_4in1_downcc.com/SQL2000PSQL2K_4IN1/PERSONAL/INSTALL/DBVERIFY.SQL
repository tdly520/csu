/*
** Copyright Microsoft, Inc. 1994 - 2000
** All Rights Reserved.
*/

declare @name as sysname

select @name=name from master.dbo.sysdatabases where
(DATABASEPROPERTY(name, N'IsDetached')=1) or
(DATABASEPROPERTY(name, N'IsShutdown')=1) or
(DATABASEPROPERTY(name, N'IsSuspect')=1) or
(DATABASEPROPERTY(name, N'IsOffline')=1) or
(DATABASEPROPERTY(name, N'IsInLoad')=1) or 
(DATABASEPROPERTY(name, N'IsInRecovery')=1) or
(DATABASEPROPERTY(name, N'IsEmergencyMode')=1) or
(DATABASEPROPERTY(name, N'IsInStandBy')=1) or
(DATABASEPROPERTY(name, N'IsReadOnly')=1) 
if (@name <> '' And (@name is not null))
begin
	RAISERROR('Database ''%s'' must be made writable before it can be upgraded.',16,1,@name)
	GOTO ENDIT
end
select @name=name from master.dbo.sysdatabases where
(has_dbaccess(name)=0)
if (@name <> '' And (@name is not null))
begin
	RAISERROR(15622,16,1,@name)
	GOTO ENDIT
end

declare @groupname as sysname
declare @SQL  nvarchar(512)
set nocount on
declare c1 cursor forward_only read_only for 
		select name from master.dbo.sysdatabases
	open c1
	fetch c1 into @name

	while @@fetch_status >= 0
	begin
		/*look for read-only filegroups for each database */
		select @SQL = 'use ' + QuoteName(@name) + ' select groupname from '+  QuoteName(@name) + '.dbo.sysfilegroups where (FILEGROUPPROPERTY(groupname, N''IsReadOnly'')=1)'
		execute(@SQL)
		if (@@ROWCOUNT > 0)
			GOTO FAILURE
		fetch c1 into @name
	end
	close c1
	deallocate c1
	GOTO ENDIT
FAILURE:
	RAISERROR('Database ''%s'' has a read only filegroup.',16,1,@name)
	close c1
	deallocate c1
ENDIT:


