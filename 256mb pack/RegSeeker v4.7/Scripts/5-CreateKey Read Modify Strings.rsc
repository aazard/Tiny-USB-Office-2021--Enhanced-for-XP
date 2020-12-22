; RegSeeker scripting test  !

RootKey HKCU
IfConfirm Ok to create new key HKCU\Software\1_RegSeeker\Test ?
{
	CreateKey Software\1_RegSeeker\Test
	ShowResult
	MessageBox Create new registry value , Let's create new string value String_Test and assign "Test 1"
	WriteString String_Test Test 1
	ShowResult
	MessageBox Read a registry value , Let's read String_Test data
	ReadString String_Test
	ShowValue

	MessageBox Modify a registry value , Let's modify String_Test value to "Test 2"
	WriteString String_Test Test 2 
	MessageBox Read the new value , Let's read new String_Test data
	ReadString String_Test
	ShowValue
}
ElseIf
{
	MessageBox Operation cancelled !
}
 
MessageBox Registry value comparison , Let's check is String_Test is equal to "Test 2"
RootKey HKCU
OpenKey Software\1_RegSeeker\Test
ReadString String_Test
IfResult Test 2
{
	MessageBox Information , OK, result is Test 2
}
ElseIf
{   
	MessageBox Information , Not good, result is  : result$ <> Test 2
}
 
IfConfirm OK to delete String_Test value in HKCU\Software\1_RegSeeker\Test key ?
{
	RootKey HKCU
	OpenKey Software\1_RegSeeker\Test
	DeleteValue String_Test
	ShowResult
}
 
IfConfirm OK to delete all HKCU\Software\1_RegSeeker key ?
{
	RootKey HKCU
	OpenKey Software
	DeleteKey 1_RegSeeker
	ShowResult
}

MessageBox Information , End of script !