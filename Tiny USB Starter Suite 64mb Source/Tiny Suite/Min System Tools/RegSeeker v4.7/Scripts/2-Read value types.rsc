; RegSeeker script example : read different value type

RootKey HKCR

; Open key in read-only mode
OpenKeyRo CompressedFolder

; Read default value
ReadString ''
ShowValue
 
; Read string FriendlyTypeName value
ReadString FriendlyTypeName
ShowValue 

; Read integer EditFlags value
ReadInteger EditFlags
ShowValue
 
CloseKey

; Read binary DigitalProductID
RootKey HKLM
OpenkeyRO SOFTWARE\Microsoft\Windows NT\CurrentVersion
ReadBinary DigitalProductId
ShowValue
