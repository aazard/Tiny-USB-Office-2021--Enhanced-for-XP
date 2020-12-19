@echo off
:-------------------------------------------------
: sample of useage wildcards with AVI2WAVCMD
: (c)2000-01 m&g software, Arminio_Grgic@Yahoo.com
:-------------------------------------------------

echo Sample of useage wildcards with AVI2WAVCMD
echo "(c)2000-01 m&g software, Arminio_Grgic@Yahoo.com"
echo.

if "%1"=="" goto nopars

: *** do the job ...
for %%a in (%1) do avi2wavcmd %%a %2

: *** ... and beep 5 times when finished.
echo 
goto end

:nopars
echo Syntax: WILDCARDS_SAMPLE filename_with_or_without_wildcards [destination_path\]
echo.
echo Example: WILDCARDS_SAMPLE g:\avis\*.avi
echo          WILDCARDS_SAMPLE *.avi  c:\wavs\
echo.

:end
