@echo off
rem 2020-08-31

setlocal enabledelayedexpansion
set CURRENTDIR=%~dp0

cd /d %CURRENTDIR% || exit /b 1

if "%1" == "x86" goto build_x86_release
if "%1" == "x64" goto build_x64_release

:build_x86_release
    if not exist build ( mkdir build )
    cd build
	cmake -G "Visual Studio 14 2015" -DCMAKE_BUILD_TYPE=Release .. || goto :error
	cmake --build . --target ALL_BUILD --config Release || goto :error
	goto :success

:build_x64_release
    if not exist build ( mkdir build )
    cd build
	cmake -G "Visual Studio 14 2015" -A x64 -DCMAKE_BUILD_TYPE=Release .. || goto :error
	cmake --build . --target ALL_BUILD --config Release || goto :error
	goto :success

:success
	echo [+] Success. build project.
	exit /b 0

:error
	echo [-] Failed with error #%errorlevel%.
	cmd /c exit %errorlevel%
