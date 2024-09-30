/*
** Copyright Microsoft, Inc. 1994 - 2000
** All Rights Reserved.
*/
set nocount on
GO

declare dbnames_cursor cursor for 
	SELECT name 
	FROM master..sysdatabases
	WHERE name not in ('pubs', 'tempdb')
GO

open dbnames_cursor
GO

declare @user_name varchar(255)
declare @db_name varchar(255)
declare @curline varchar(255)
declare @mappedname varchar(255)

fetch dbnames_cursor into @db_name
while @@fetch_status <> -1
	begin
		SELECT @user_name = (SELECT master..syslogins.name FROM master..sysdatabases, master..syslogins 
		WHERE master..sysdatabases.suid = master..syslogins.suid 
		AND master..sysdatabases.name = @db_name)

		SELECT @mappedname = (select distinct ntname from master..upg_loginmap where sqlname = @user_name)

		if @mappedname is not null
			select @user_name = @mappedname

		if @user_name <> 'sa'
			begin
				SELECT @curline = "if exists (select name from sysdatabases where name = '" + @db_name + "')"
				print @curline

				SELECT @curline = (select "    EXEC('USE [" + @db_name + "] exec sp_changedbowner [" + @user_name + "]')")		
				print @curline

				print 'return'
				print ''
				print 'GO'
				print ''
			end

		fetch dbnames_cursor into @db_name
	end
GO

deallocate dbnames_cursor
GO

set nocount off
GO
