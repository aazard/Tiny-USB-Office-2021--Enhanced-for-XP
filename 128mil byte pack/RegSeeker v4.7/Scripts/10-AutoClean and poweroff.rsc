; RegSeeker script exemple : AutoClean Advanced version only

; let's close Chrome and IE before cleaning
killproc chrome
killproc iexplore

; let's perform autocleaning !
doautoclean
	
; shutdown after cleaning
shutdown /force