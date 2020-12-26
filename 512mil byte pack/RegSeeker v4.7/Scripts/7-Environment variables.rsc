; RegSeeker script example : variable environment

string$ = ''	; example to empty string

getenvvar computername
string$ = Computer <tab> result$ <cr>
getenvvar username
string$ = string$ + Username <tab> result$ <cr>
getenvvar userdomain
string$ = string$ + Domain <tab> <tab> result$ <cr>
getenvvar logonserver
string$ = string$ + Logon server <tab> result$ <cr>
getenvvar userprofile
string$ = string$ + User profile <tab> result$ <cr>
getenvvar allusersprofile
string$ = string$ + All users profile <tab> result$ <cr>

If64bit		; let's test if Windows OS is 64bit
{
	getenvvar programw6432
	string$ = string$ + ProgramW6432 <tab> result$ <cr>
}

getenvvar programfiles
string$ = string$ + ProgramFiles <tab> result$ <cr>
getenvvar windir
string$ = string$ + Windows dir <tab> result$

messagebox Variables environment , <cr> string$ 