@echo off
:: Run Adobe DNG converter, e.g. for .CR3 files not supported by DCRAW yet.
set dngconv="%ProgramW6432%\Adobe\Adobe DNG Converter\Adobe DNG Converter.exe"
start "Adobe DNG Converter" /wait %dngconv% -c -d "%~dp1" -o "%~nx1.dng" "%~f1"
