; This export requires AHK_L to be installed as your
; main AutoHotkey install if you want UTF-8 file
; encoding to work.  Otherwise, you will have to 
; comment out the following line:
FileEncoding, UTF-8

; Set environment.
#NoEnv
#NoTrayIcon
#SingleInstance, Off
SetBatchLines, -1
SetControlDelay, -1
DetectHiddenWindows, On
SetWorkingDir, %A_ScriptDir%


; Read in passed file.
myFilePath = %1%
FileRead, myFileData, % myFilePath

MsgBox, % myFileData

; Do whatever you want with the data here...