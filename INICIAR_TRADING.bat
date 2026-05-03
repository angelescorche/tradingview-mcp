@echo off
title TRADING SUITE
color 0A
echo.
echo Iniciando TradingView con debug port...
powershell -Command "Start-Process 'C:\Program Files\WindowsApps\TradingView.Desktop_3.1.0.7818_x64__n534cwy3pjxzj\TradingView.exe' -ArgumentList '--remote-debugging-port=9222'"
echo TradingView lanzado. Esperando 8 segundos...
timeout /t 8 /nobreak
echo.
echo Abriendo Claude Code...
cd /d "%USERPROFILE%\tradingview-mcp"
claude
