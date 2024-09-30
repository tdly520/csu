@echo off
rem 	Performs Unattended UnInstall operation
rem
rem     command line argument specifying the short filename of the sql install path
rem     is required, e.g., c:\mssql7
rem
rem     A second command line argument specifying the instance name is also required
rem	for all server uninstalls.  If the instance name is not specified the uninstall
rem 	command corresponds to a Tools only uninstall.
rem     
rem
rem
SET SQLPath=%1
if '%SQLPath%' == '' goto pathnotok
if exist %SQLPath%\uninst.isu goto pathok
:pathnotok
echo "Usage: sqlrem.bat <sql install path> [<instance name>]"
goto endit
:pathok
SET Instance=%2
if '%Instance%' == '' goto toolsonly
@echo on
start /wait isuninst.exe -a -y -x -msql.mif -f%SQLPath%\uninst.isu -C%SQLPath%\sqlsun.dll i=%Instance%
@echo off
goto endit
:toolsonly
@echo on
start /wait isuninst.exe -a -y -x -msql.mif -f%SQLPath%\uninst.isu -C%SQLPath%\sqlsun.dll
@echo off
:endit