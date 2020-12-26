; RegSeeker script example (Advanced) : test if application exists and start uninstall

IsInstalled 7-Zip 16.04 (x64)
IfResult SUCCESS
{
	IfConfirm OK to uninstall 7-Zip ?
	{
		RemoveApp 7-Zip 16.04 (x64) ; advanced version only !
	}
	ElseIf
	{
		Messagebox Information, Nothing done !
	}
}
