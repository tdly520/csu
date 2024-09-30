@echo off
rem 	Performs SQL Server Full Server Unattended Install operation

rem 	Before running this batch file, you must edit the corresponding 
rem	unattended install file (sqlcst.iss), and enter your 
rem	Product Key (CD-Key) from your CD.


cls

echo *
echo     Unattended install for SQL Server is starting.
echo *
echo *
echo     Waiting for SQL Server Setup to finish...


@echo on
start /wait x86\setup\setupsql.exe k=SMS -s -m -SMS -f1 "sqlcst.iss"
@echo off
