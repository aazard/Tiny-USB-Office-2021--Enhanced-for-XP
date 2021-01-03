; RegSeeker script exemple to display Windows version

RootKey HKLM
OpenKey Software\Microsoft\Windows NT\CurrentVersion
IfResult SUCCESS
{
	ReadString ProductName
	string$ = result$
	if64bit
	{
		string$ = string$ + <sp> + (64bit)
	}
	ReadInteger  CurrentMajorVersionNumber ; read major version and store the result
	string$ = <cr> + string$ + <cr> + Version : + <tab> + <tab> + result$
	ReadInteger  CurrentMinorVersionNumber ; let's read minor version
	string$ = string$ + . + result$ ; save majorversion.minorversion
	ReadString CurrentBuild ; read build number
	string$ = string$ + . + result$ ; add current build to major.minor
	ReadString ReleaseId ;let's read releaseid
	string$ = string$ + <cr> Release : + <tab> + <tab> + result$ ; add releaseid to the current string
	ReadString registeredowner ; read registered owner
	string$ = string$ + <cr> Owner : + <tab> + <tab> + result$
	ReadString ProductID
	MessageBox Windows information , Windows : <tab> <tab> string$ <cr> ProductID : <tab> result$ ; display the result
}
ElseIf 
{
	MessageBox Can not open key !, Key is protected or does not exist <cr> Let's open it in read-only mode
	OpenKeyRo Software\Microsoft\Windows NT\CurrentVersion
 	IfResult ERROR
	{
		MessageBox Key doesn't seem to exist !
	}
	ElseIf
	{
		ReadString ProductName
		string$ = result$
		if64bit
		{
			string$ = string$ + <sp> + (64bit)
		}
		ReadInteger  CurrentMajorVersionNumber ; read major version and store the result
		string$ = <cr> + string$ + <cr> + Version : + <tab> + <tab> + result$
		ReadInteger  CurrentMinorVersionNumber ; let's read minor version
		string$ = string$ + . + result$ ; save majorversion.minorversion
		ReadString CurrentBuild ; read build number
		string$ = string$ + . + result$ ; add current build to major.minor
		ReadString ReleaseId ;let's read releaseid
		string$ = string$ + <cr> Release : + <tab> + <tab> + result$ ; add releaseid to the current string
		ReadString registeredowner ; read registered owner
		string$ = string$ + <cr> Owner : + <tab> + <tab> + result$
		ReadString ProductID
		MessageBox Windows information , Windows : <tab> <tab> string$ <cr> ProductID : <tab> result$ ; display the result
	}
}