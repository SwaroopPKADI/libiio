@echo off
start cmd /k "cd /d C:\Users\SGudla && set PATH=C:\Program Files (x86)\libiio\lib\libiio;%PATH% && iio_info --version"