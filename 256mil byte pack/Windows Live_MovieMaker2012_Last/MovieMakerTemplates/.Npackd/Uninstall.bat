msiexec.exe /qn /norestart /Lime .Npackd\UninstallMSI.log /x{dd67be4b-7e62-4215-afa3-f123a800a389}
set err=%errorlevel%
type .Npackd\UninstallMSI.log
rem 3010=restart required
if %err% equ 3010 exit 0
rem 1605=unknown product
if %err% equ 1605 exit 0
if %err% neq 0 exit %err%
