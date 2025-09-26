@echo off
chcp 65001 >nul
title BPC Download Tool

echo ==========================================
echo           BPC Download Tool
echo ==========================================
echo.
echo Starting download script...
echo.

powershell.exe -ExecutionPolicy Bypass -NoProfile -File "%~dp0download_script.ps1"

REM Script will close automatically after PowerShell execution