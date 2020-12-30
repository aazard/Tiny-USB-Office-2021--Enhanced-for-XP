; Set registry values for Privacy settings in Windows 10
; Works with Advanced version and RegSeeker started with administrator rights

; First : Let's stop telemetry services if running and prevent automatic service startup

load sc <stop DiagTrack>
load sc <stop dmwappushservice>
load sc <config DiagTrack start= disabled>
load sc <config dmwappushservice start= disabled>


rootkey HKCU

; Disable Let apps use my advertising ID for experiences across apps
openkey SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo
IfResult SUCCESS
{
	WriteInteger Enabled 0
	String$ = Let apps use my advertising ID... <tab> <tab> Done
}
ElseIf
{
	String$ = Let apps use my advertising ID... <tab> <tab>  N/A
}
closekey

; Disable Feedback
openkey SOFTWARE\Microsoft\Siuf\Rules
IfResult SUCCESS
{
	WriteInteger NumberOfSIUFInPeriod 0
	WriteInteger PeriodInNanoSeconds 0
	String$ = string$ + <cr> +  Feedback <tab> <tab> <tab> <tab> <tab> Done
}
ElseIf
{
	String$ = string$ + <cr> +  Feedback <tab> <tab> <tab> <tab> <tab> N/A
}
CloseKey

; Disable Windows spotlight : background images and text on the lock screen, suggested apps
openkey SOFTWARE\Policies\Microsoft\Windows\CloudContent
IfResult SUCCESS
{
	WriteInteger DisableWindowsSpotlightFeatures 1
	String$ = String$ + <cr> + Windows spotlight <tab> <tab> <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Windows spotlight <tab> <tab> <tab> <tab> N/A
}
CloseKey

; Disable Live tiles
createkey SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications
IfResult SUCCESS
{
	WriteInteger NoTileApplicationNotification 1
	String$ = String$ + <cr> + Live tiles <tab> <tab> <tab> <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Live tiles <tab> <tab> <tab> <tab> <tab> N/A
}
CloseKey


; Disable Let apps run in the background
openkey SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications
IfResult SUCCESS
{
	WriteInteger GlobalUserDisabled 1
	String$ = String$ + <cr> + Let apps run in the background <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Let apps run in the background <tab> <tab> N/A
}
CloseKey

; Disable Get tips, tricks, and suggestions notification when using Windows
openkey SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager
IfResult SUCCESS
{
	WriteInteger SoftLandingEnabled 0
	String$ = String$ + <cr> + Get tips, tricks, and suggestions <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Get tips, tricks, and suggestions <tab> <tab> N/A
}
CloseKey

; Disable Ads in Windows File explorer
openkey SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced
IfResult SUCCESS
{
	WriteInteger ShowSyncProviderNotifications 0
	String$ = String$ + <cr> + Ads in File explorer <tab> <tab> <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> +Ads in File explorer <tab> <tab> <tab> <tab> N/A
}
CloseKey

; Disable Input personalization
openkey SOFTWARE\Microsoft\InputPersonalization
IfResult SUCCESS
{
	WriteInteger RestrictImplicitInkCollection 1
	WriteInteger RestrictImplicitTextCollection 1
	WriteInteger AllowInputPersonalization 0

	String$ = String$ + <cr> +  Input personalization <tab> <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Input personalization <tab> <tab> <tab> N/A
}
Closekey

; Disable Let websites provide locally relevant content by accessing my language list
openkey Control Panel\International\User Profile
IfResult SUCCESS
{
	WriteInteger HttpAcceptLanguageOptOut 1
	String$ = String$ + <cr> + Let websites provide locally relevant... <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Let websites provide locally relevant... <tab> <tab> N/A
}
CloseKey

; Disable Smartscreen for Windows store apps
openkey Software\Microsoft\Windows\CurrentVersion\AppHost
IfResult SUCCESS
{
	DeleteValue EnableWebContentEvaluation
	String$ = String$ + <cr> + Smartscreen for Windows store apps <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Smartscreen for Windows store apps <tab> <tab> N/A
}
CloseKey

; Disable Web search in Start Menu
openkey SOFTWARE\Microsoft\Windows\CurrentVersion\Search
IfResult SUCCESS
{
	WriteInteger BingSearchEnabled 0
	String$ = String$ + <cr> + Websearch in Start Menu <tab> <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Websearch in Start Menu <tab> <tab> <tab> N/A
}
CloseKey

; Disable Let apps access my name, picture and other account info
openkey SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}
IfResult SUCCESS
{
	WriteString Value Deny
	String$ = String$ + <cr> + Let apps access my name, picture...<tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Let apps access my name, picture... <tab> <tab> N/A
}
CloseKey

; Disable Let apps access my call history
openkey SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}
IfResult SUCCESS
{
	WriteString Value Deny
	String$ = String$ + <cr> + Let apps access my call history...<tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Let apps access my call history... <tab> <tab> N/A
}
CloseKey

; Disable Let your apps automatically share and sync info with wireless devices tat don't explicitly pair with your PC, tablet or phone
openkey SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled
IfResult SUCCESS
{
	WriteString Value Deny
	String$ = String$ + <cr> + Let your apps automatically share and sync...<tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Let your apps automatically share and sync... <tab> N/A
}
CloseKey


; Remove occasional suggestions in Start menu (ADs), Pre-installed apps, fun facts on lock screen
openkey Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager
IfResult SUCCESS
{
	WriteInteger RotatingLockScreenEnabled 0
	WriteInteger RotatingLockScreenOverlayEnabled 0
	WriteInteger SystemPaneSuggestionsEnabled 0
	WriteInteger PreInstalledAppsEnabled 0
	WriteInteger PreInstalledAppsEverEnabled 0
	WriteInteger SubscribedContentEnabled 0
	DeleteKey SuggestedApps
	String$ = String$ + <cr> + Suggestions, preinstalled apps <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Suggestions, preinstalled apps <tab> <tab> N/A
}



; Go for HKEY_LOCAL_MACHINE settings


RootKey HKLM

; Disable Cortana
openkey SOFTWARE\Policies\Microsoft\Windows\Windows Search
IfResult SUCCESS
{
	WriteInteger AllowCortana 0
	String$ = String$ + <cr> + Disable Cortana <tab> <tab> <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Disable Cortana <tab> <tab> <tab> <tab> N/A
}
CloseKey

; Disable Error reporting
openkey SOFTWARE\Microsoft\Windows\Windows Error Reporting
IfResult SUCCESS
{
	WriteInteger Disabled 1
	String$ = String$ + <cr> + Error reporting ... <tab> <tab> <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Error reporting ... <tab> <tab> <tab> <tab> N/A
}
CloseKey

; Remove cloud apps like Candy Crush Saga...
openkey SOFTWARE\Policies\Microsoft\Windows\CloudContent
IfResult SUCCESS
{
	WriteInteger DisableWindowsConsumerFeatures 1
	WriteInteger DisableSoftLanding 1
	String$ = String$ + <cr> + Cloud apps and tips <tab> <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Cloud apps and tips <tab> <tab> <tab> N/A
}
CloseKey

; Disable Diagnostics and usage data
openkey Software\Policies\Microsoft\Windows\DataCollection
IfResult SUCCESS
{
	WriteInteger AllowTelemetry 0
	String$ = String$ + <cr> + Send device data to Microsoft <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Send device data to Microsoft <tab> <tab> N/A
}
CloseKey

; Disable Apps Diagnostics info
openkey Software\Policies\Microsoft\Windows\AppPrivacy
IfResult SUCCESS
{
	WriteInteger 	LetAppsGetDiagnosticInfo 2
	String$ = String$ + <cr> + Let apps access diagnostic info <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Let apps access diagnostic info <tab> <tab> N/A
}
CloseKey

; Restrict Windows update from using P2P
OpenKey SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config
IfResult SUCCESS
{
	deletevalue DODownloadMode
	String$ = String$ + <cr> + P2P Windows update <tab> <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + P2P Windows update <tab> <tab> <tab> N/A
}
CloseKey

; Disable Let apps automatically share ...
OpenKey Software\Policies\Microsoft\Windows\System
IfResult SUCCESS
{
	WriteInteger EnableCdp 0
	String$ = String$ + <cr> + Let apps automatically share...<tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Let apps automatically share...<tab> <tab> N/A
}
CloseKey


; Disable Let apps on other devices open apps on this device
openkey SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass

IfResult SUCCESS
{
	WriteInteger UserAuthPolicy 0
	String$ = String$ + <cr> + Let apps on other devices open... <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Let apps on other devices open... <tab> <tab> N/A
}
closekey

; Disable Wifi Sense
OpenKey SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config
IfResult SUCCESS
{
	WriteInteger AutoConnectAllowedOEM 0
	String$ = String$ + <cr> + Wi-Fi Sense <tab> <tab> <tab> <tab> Done
}
ElseIf
{
	String$ = String$ + <cr> + Wi-Fi Sense <tab> <tab> <tab> <tab> N/A
}
CloseKey

MessageBox Windows 10 : Disable tracking ads suggestions ..., string$