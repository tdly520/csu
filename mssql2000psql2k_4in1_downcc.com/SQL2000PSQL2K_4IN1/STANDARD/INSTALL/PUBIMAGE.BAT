@echo off
if "%1" == "" goto usage
echo.
echo Inserting images into pubs database on server %1
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Clogo -W"where pub_id = '1389'" -Falgodata.gif
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Clogo -W"where pub_id = '0877'" -Fbinnet.gif
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Clogo -W"where pub_id = '9901'" -Fgggg.gif
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Clogo -W"where pub_id = '1622'" -F5lakes.gif
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Clogo -W"where pub_id = '0736'" -Fnewmoon.gif
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Clogo -W"where pub_id = '9999'" -Flucerne.gif
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Clogo -W"where pub_id = '1756'" -Framona.gif
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Clogo -W"where pub_id = '9952'" -Fscootney.gif
echo Image update complete!
echo.
goto done
:usage
echo.
echo Usage: pubimage ServerName [SAPassword]
echo.
:done
