@echo off
setlocal

set repo_root=%~dp0
if "%repo_root:~-1%"=="\" set repo_root=%repo_root:~0,-1%
set build_dir=%repo_root%\build
set deps_dir=%repo_root%\deps
set venv_dir=%repo_root%\..\venv
set venv_python=%venv_dir%\Scripts\python.exe
set venv_scripts=%venv_dir%\Scripts
set python_bindings_dir=%repo_root%\bindings\python

REM Try to delete the existing build folder
echo Attempting to remove existing build directory...

rmdir /s /q "%build_dir%" 2>nul

REM Check if deletion succeeded
if exist "%build_dir%" (
    echo Failed to delete 'build' folder. It may be in use or locked.
    echo Please close any programs or windows using the folder.
    pause
    exit /b 1
)

REM Recreate and build
mkdir "%build_dir%"
cd /d "%build_dir%"

cmake .. -G "Visual Studio 18 2026" -A x64 ^
-DWITH_MODULES=OFF -DWITH_SERIAL_BACKEND=ON -DWITH_ZSTD=ON -DWITH_USB_BACKEND=OFF -DWITH_NETWORK_BACKEND=OFF -DWITH_LOCAL_BACKEND=OFF -DCSHARP_BINDINGS=ON -DPYTHON_BINDINGS=ON ^
-DLIBSERIALPORT_LIBRARIES="%deps_dir%\libserialport\x64\Release\libserialport.lib" ^
-DLIBSERIALPORT_INCLUDE_DIR="%deps_dir%\libserialport" ^
-DLIBXML2_LIBRARIES="%deps_dir%\libxml2-install\lib\libxml2.lib" ^
-DLIBXML2_INCLUDE_DIR="%deps_dir%\libxml2-install\include\libxml2" ^
-DLIBUSB_LIBRARIES="%deps_dir%\libusb\VS2022\MS64\dll\libusb-1.0.lib" ^
-DLIBUSB_INCLUDE_DIR="%deps_dir%\libusb\include" ^
-DLIBZSTD_LIBRARIES="%deps_dir%\zstd\build\VS2010\bin\x64_Release\libzstd.lib" ^
-DLIBZSTD_INCLUDE_DIR="%deps_dir%\zstd\lib" ^
-DLOG_LEVEL=Debug

if errorlevel 1 exit /b %errorlevel%

cmake --build . --config RelWithDebInfo --target install

if errorlevel 1 exit /b %errorlevel%

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
set dest="%repo_root%\my_build\%folder%"

REM Create destination folder
mkdir "%dest%"

copy /y "%build_dir%\RelWithDebInfo\libiio1.dll" "%dest%\" >nul
copy /y "%build_dir%\RelWithDebInfo\iio.dll" "%dest%\" >nul
copy /y "%deps_dir%\libusb\VS2022\MS64\dll\libusb-1.0.dll" "%dest%\" >nul
copy /y "%deps_dir%\libserialport\x64\Release\libserialport.dll" "%dest%\" >nul
copy /y "%deps_dir%\zstd\build\VS2010\bin\x64_Release\libzstd.dll" "%dest%\" >nul
copy /y "%deps_dir%\libxml2-install\bin\libxml2.dll" "%dest%\" >nul

if errorlevel 1 exit /b %errorlevel%

echo Done
pause