msiexec.exe /qn /norestart /Lime .Npackd\UninstallMSI.log /x{c992ffe0-ac32-4fa9-bc9a-f1637b9e655d}
set err=%errorlevel%
type .Npackd\UninstallMSI.log
rem 3010=restart required
if %err% equ 3010 exit 0
rem 1605=unknown product
if %err% equ 1605 exit 0
if %err% neq 0 exit %err%
