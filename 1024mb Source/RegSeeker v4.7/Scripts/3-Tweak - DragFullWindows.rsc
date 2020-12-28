; RegSeeker tweak exemple to enable/disable full content display while moving a window

Rootkey HKCU
OpenKey Control Panel\Desktop

IfConfirm Enable content display while moving a window ?
{
	WriteString DragFullWindows 1
	IfResult SUCCESS
	{
		MessageBox Information , Content display is enabled!
	}
}
ElseIf
{
	WriteString DragFullWindows 0
	IfResult SUCCESS
	{
		MessageBox Information , Content display is disabled!
	}
}
IfConfirm Ok to close your session to apply changes ?
{ 
	Logoff	; Advanced version only !
}