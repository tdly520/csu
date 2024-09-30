@echo off
if '%PROCESSOR_ARCHITECTURE%'=='' goto Win9x
cd %PROCESSOR_ARCHITECTURE%\other\ie4
if '%1' == 'F' goto NTFull
start ie4setup.exe /c:"ie4wzd.exe /I:N /S:""#e"" /M:0"
goto END
:NTFull
start ie4setup.exe
goto END
:Win9x
cd x86\other\ie4
if '%1' == 'F' goto Win9xFull
start ie4setup.exe /c:"ie4wzd.exe /I:N /S:""#e"" /M:0"
goto END
:Win9xFull
start ie4setup.exe
:END