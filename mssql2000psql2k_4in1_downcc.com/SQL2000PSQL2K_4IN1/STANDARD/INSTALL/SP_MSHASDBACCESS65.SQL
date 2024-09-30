/*
** Copyright Microsoft, Inc. 1994 - 2000
** All Rights Reserved.
*/
-- =============================================
-- sp_MShasdbaccess
-- =============================================
-- List all databases along with their owner 
-- and db properties
--
-- PARAMETERS: N/A
--
-- REMARKS: for SQL Server 6.5
-- =============================================
create proc sp_MShasdbaccess 
as 

select name as 'dbname',
owner = substring(suser_name(suid), 1, 24),
(status&2048) as 'DboOnly',
(status&1024) as 'ReadOnly',
(status&4096) as 'SingleUser',
NULL as 'Detached',
(status&256) as	'Suspect',
(status&512) as	'Offline',
(status&32) as 'InLoad',
(status&32768) as 'EmergencyMode',
NULL as 'StanBy',
NULL as 'ShutDown',
(status&128) as	'InRecovery',
(status&64) as	'NotRecovered'

from sysdatabases
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
