@echo off
if "%1" == "" goto usage
echo.
echo Inserting text into pubs database on server %1
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Cpr_info -W"where pub_id = '1389'" -Falgodata.txt
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Cpr_info -W"where pub_id = '0877'" -Fbinnet.txt
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Cpr_info -W"where pub_id = '9901'" -Fgggg.txt
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Cpr_info -W"where pub_id = '1622'" -F5lakes.txt
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Cpr_info -W"where pub_id = '0736'" -Fnewmoon.txt
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Cpr_info -W"where pub_id = '9999'" -Flucerne.txt
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Cpr_info -W"where pub_id = '1756'" -Framona.txt
textcopy -I -Usa -P%2 -S%1 -Dpubs -Tpub_info -Cpr_info -W"where pub_id = '9952'" -Fscootney.txt
echo Text update complete!
echo.
goto done
:usage
echo.
echo Usage: pubtext ServerName [SAPassword]
echo.
:done

