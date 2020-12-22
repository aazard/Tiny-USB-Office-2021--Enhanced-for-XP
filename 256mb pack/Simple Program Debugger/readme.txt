SimpleProgramDebugger v1.10
Copyright (c) 2014 - 2020 Nir Sofer


Description
===========

SimpleProgramDebugger is a simple debugging tool for Windows that
attaches to existing running program or starts a new program in debugging
mode, and then displays all major debugging events occurs while the
program is running, including Exception, Create Thread, Create Process,
Exit Thread, Exit Process, Load DLL, Unload Dll, and Debug String.
After the debugging events are accumulated, you can easily export them
into comma-delimited/tab-delimited/xml/html file or copy them to the
clipboard and then paste them into Excel or any other spreadsheet
application.

System Requirements
===================

This utility works on any version of Windows, starting from Windows XP
and up to Windows 10. Both 32-bit and 64-bit systems are supported.

Start Using SimpleProgramDebugger
=================================

SimpleProgramDebugger doesn't require any installation process or
additional dll files. In order to start using it, simply run the
executable file - SimpleProgramDebugger.exe

After running SimpleProgramDebugger, you can attach a program that is
already running by pressing F7 and choosing the desired process, or you
can start a new program by pressing Ctrl+N and choosing the .exe file to
run, and optionally parameters and start folder.

After the debugging events are displayed in the main window of
SimpleProgramDebugger, you can select one or more events, and then use
the 'Save Selected items' option to export them into
comma-delimited/tab-delimited/xml/html file or press Ctrl+C to copy them
to the clipboard, and then paste them into Excel or any other spreadsheet
application.

Command-Line Options
====================

/DebugProcess <Process ID/Filename>
Start to debug an existing process. You can specify the process ID or
process filename, for example:
SimpleProgramDebugger.exe /DebugProcess explorer.exe
SimpleProgramDebugger.exe /DebugProcess "c:\temp\myexe.exe"
SimpleProgramDebugger.exe /DebugProcess 4522

/StartDebugProcess
Start a new process and debug it. You can specify the process filename in
the /NewProcess.ProcessPath command-line option, the process parameters
in the /NewProcess.Params command-line option and the process start
folder in the /NewProcess.StartFolder command-line option.

Example:
SimpleProgramDebugger.exe /StartDebugProcess /NewProcess.ProcessPath
"c:\windows\system32\taskmgr.exe"

/NewProcess.ProcessPath <Process Filename>
Specifies the process filename to start, for using with the
/StartDebugProcess command.

/NewProcess.Params <Command-Line Parameters>
Specifies the parameters for the process to start, for using with the
/StartDebugProcess command.

/NewProcess.StartFolder <Process Start Folder>
Specifies the start folder of the process, for using with the
/StartDebugProcess command.

/RunAsAdmin
Run SimpleProgramDebugger as Administrator.