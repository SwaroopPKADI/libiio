@echo off
REM Get current date and time components
for /f "tokens=2 delims==" %%I in ('"wmic os get localdatetime /value"') do set datetime=%%I

REM Extract date and time parts
set year=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%
set hour=%datetime:~8,2%
set min=%datetime:~10,2%

REM Format folder name as build_<day>_<hour>_<min>
set folder=build_%day%_%hour%_%min%

REM Set destination path
set dest=C:\Projects\libiio_10\libiio\my_build\%folder%

REM Create destination folder
mkdir "%dest%"

REM Copy DLLs
copy "C:\Projects\libiio_10\libiio\build\Release\libiio1.dll" "%dest%"
copy "C:\Projects\libiio_10\libiio\build\Release\libiio-serial.dll" "%dest%"

REM Copy all EXEs
copy "C:\Projects\libiio_10\libiio\build\utils\Release\*.exe" "%dest%"

echo Files copied to %dest%
pause