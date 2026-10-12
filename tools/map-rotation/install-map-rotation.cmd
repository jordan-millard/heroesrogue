@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0rotation-helper.ps1" -Install
pause
