; RegSeeker script example : starting/closing process

IsRunning notepad
IfResult SUCCESS
{
	messagebox Closing process , Notepad is running ... <cr> Let's close it !
	quit notepad		; advanced version only !
}
ElseIf
{
	messagebox Starting process , Notepad is not running ... <cr> Let's start it !
	load notepad	; advanced version only !
}