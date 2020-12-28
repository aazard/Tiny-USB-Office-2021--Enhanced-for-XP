; RegSeeker script exemple : test result with custom string value

Rootkey hklm
OpenKeyRo Software\Microsoft\Windows NT\CurrentVersion
string$ = 6.3

ReadString CurrentVersion

IfResult string$
{
	MessageBox Windows version , Your Windows is up to date ! <cr> Version : result$
}
ElseIf
{
	MessageBox Windows version , This is not the latest version ! <cr> Version : result$
}