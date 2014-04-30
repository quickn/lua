@echo off
set QUICK="%QUICK_COCOS2DX_ROOT%"\player\bin\win32\quick-x-player.exe
set PROJECT=D:\git\luaJava\Luajavabridge
set SIZE=800x480
start "Quick X Player " "%QUICK%" -workdir %PROJECT% -file %PROJECT%\assets\scripts\main.lua -size %SIZE%