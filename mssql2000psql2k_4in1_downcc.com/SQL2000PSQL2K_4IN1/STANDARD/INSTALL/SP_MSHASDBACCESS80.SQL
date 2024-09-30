/*
** Copyright Microsoft, Inc. 1994 - 2000
** All Rights Reserved.
*/
-- =============================================
-- sp_MShasdbaccess
-- =============================================
-- List all databases a user has access to
-- along with their db properties
--
-- PARAMETERS: N/A
--
-- REMARKS: for SQL Server 7.0 and 8.0
-- =============================================
create proc sp_MShasdbaccess 
as 

select name as 'dbname', 
owner = substring(suser_sname(sid), 1, 24), 
DATABASEPROPERTY(name, N'IsDboOnly') as 'DboOnly', 
DATABASEPROPERTY(name, N'IsReadOnly') as 'ReadOnly', 
DATABASEPROPERTY(name, N'IsSingleUser') as 'SingleUser', 
DATABASEPROPERTY(name, N'IsDetached') as 'Detached', 
DATABASEPROPERTY(name, N'IsSuspect') as 'Suspect', 
DATABASEPROPERTY(name, N'IsOffline') as 'Offline', 
DATABASEPROPERTY(name, N'IsInLoad')  as 'InLoad', 
DATABASEPROPERTY(name, N'IsEmergencyMode') as 'EmergencyMode', 
DATABASEPROPERTY(name, N'IsInStandBy') as 'StandBy', 
DATABASEPROPERTY(name, N'IsShutdown')  as 'ShutDown', 
DATABASEPROPERTY(name, N'IsInRecovery') as 'InRecovery', 
DATABASEPROPERTY(name, N'IsNotRecovered') as 'NotRecovered'

from master.dbo.sysdatabases
where has_dbaccess(name) = 1
order by name 
-- =============================================
-- end sp_MShasdbaccess
-- =============================================

-- =============================================
-- set permissions
-- =============================================
grant execute on sp_MShasdbaccess to public
go
-- =============================================
-- end set permissions
-- =============================================
