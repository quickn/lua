@echo off

set DIR=%~dp0
set APP_ROOT=%DIR%..\
set APP_ANDROID_ROOT=%DIR%
set COCOS2DX_ROOT=%QUICK_COCOS2DX_ROOT%\lib\cocos2d-x

echo - config:
echo   ANDROID_NDK_ROOT    = %ANDROID_NDK_ROOT%
echo   QUICK_COCOS2DX_ROOT = %QUICK_COCOS2DX_ROOT%
echo   COCOS2DX_ROOT       = %COCOS2DX_ROOT%
echo   APP_ROOT            = %APP_ROOT%
echo   APP_ANDROID_ROOT    = %APP_ANDROID_ROOT%

rem if use quick-cocos2d-x mini, uncomments line below
rem set NDK_BUILD_FLAGS=CPPFLAGS=-DQUICK_MINI_TARGET=1 QUICK_MINI_TARGET=1

rem if use DEBUG, set NDK_DEBUG=1, otherwise set NDK_DEBUG=0
set NDK_DEBUG=1
