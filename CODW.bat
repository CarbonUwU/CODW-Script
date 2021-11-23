:: Simple script to rename the file ModernWarfare.exe to ModernWarfare1.exe to prevent chrashes
@ECHO off
:: Change your install path here
set place="PATH"
set PROCNAME="ModernWarfare.exe"

	:startbattlenet
Echo Start Battle.net...
"%place%\Modern Warfare Launcher.exe"
@ping -n 5 localhost> nul
cls
:checkstart
TaskList|Find "Blizzard Battle.net App" >NUL || If Errorlevel 1 Goto startgame
Goto checkstart


	:startgame
echo checking game status...
tasklist /FI "IMAGENAME eq %PROCNAME%*" 2>NUL | find /I /N %PROCNAME%>NUL
if "%ERRORLEVEL%"=="0" (
    Goto gameruns
)
cls
Goto startgame


	:exitgame
echo checking game status...
tasklist /FI "IMAGENAME eq %PROCNAME%*" 2>NUL | find /I /N %PROCNAME%>NUL
if "%ERRORLEVEL%"=="0" (
	cls
    Goto exitgame
)
cls
Goto gamequits

	:gameruns
@ping -n 5 localhost> nul
ren "%place%\ModernWarfare.exe" ModernWarfare1.exe >nul
if exist "%place%\ModernWarfare1.exe" goto startrenameok
echo Oops, something went wrong. Let's try it again
@pause
goto startgame

	:startrenameok
cls
ECHO File renamed successfully!
@ping -n 2 localhost> nul
ECHO Changing priority...
wmic process where name="ModernWarfare.exe" CALL setpriority "normal" >nul
ECHO Priority changed to normal
@ping -n 3 localhost> nul
ECHO Have fun playing
@ping -n 5 localhost> nul
cls
GOTO exitgame

	:gamequits
ren "%place%\ModernWarfare1.exe" ModernWarfare.exe >nul
if exist "%place%\ModernWarfare.exe" goto quitrenameok
echo Oops, something went wrong. Let's try it again
goto startgame

	:quitrenameok
cls
ECHO File renamed successfully!
ECHO I hope it was fun.
GOTO exitscript

	:exitscript
echo.
echo Script will be terminated...
@ping -n 3 localhost> nul
exit