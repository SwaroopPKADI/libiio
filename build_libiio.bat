@echo off
setlocal

REM Try to delete the existing build folder
echo Attempting to remove existing build directory...

rmdir /s /q build 2>nul

REM Check if deletion succeeded
if exist build (
    echo Failed to delete 'build' folder. It may be in use or locked.
    echo Please close any programs or windows using the folder.
    pause
    exit /b 1
)

REM Recreate and build
mkdir build
cd build

cmake -DWITH_MODULES=ON -DWITH_SERIAL_BACKEND=ON -DWITH_ZSTD=OFF -DWITH_USB_BACKEND=OFF -DWITH_NETWORK_BACKEND=OFF -DWITH_LOCAL_BACKEND=OFF ^
-DLIBSERIALPORT_LIBRARIES="C:\deps\libserialport\x64\Release\libserialport.lib" ^
-DLIBSERIALPORT_INCLUDE_DIR="C:\deps\libserialport" ^
-DLIBXML2_LIBRARIES="C:\deps\libiio-win-deps\libs\64\libxml2.lib" ^
-DLIBXML2_INCLUDE_DIR="C:\deps\libiio-win-deps\include\libxml2" ^
-DLOG_LEVEL=Debug ..

cmake --build . --config Release

echo Done
pause