; RegSeeker script exemple : Clean notification area icons (remove old notification icons)

RootKey HKCU
OpenKey SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify

IfConfirm Clean old notification area icons ?
{
	DeleteValue IconStreams
	DeleteValue PromotedIconCache
	DeleteValue UserStartTime
	DeleteValue LastAdvertisement
	DeleteValue PastIconsStream
	Reload Explorer	; Advanced version only
	MessageBox Notification area icons cleaning, All was done !
}
ElseIf
{
	MessageBox Information, Nothing done !
}
