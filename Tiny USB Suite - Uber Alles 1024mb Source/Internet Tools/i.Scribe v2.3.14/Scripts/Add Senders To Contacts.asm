G0 = (int) -1426128894
G1 = (string) 'CurrentFolder'
G2 = null
G3 = (string) 'Path'
G4 = (string) 'Src=''
G5 = (string) ''...' (2 bytes)
G6 = (string) 'Dest=''
G7 = (string) ''...' (2 bytes)
G8 = (string) 'HashTable'
G9 = (string) 'Length'
G10 = (int) 0
G11 = (string) 'Item'
G12 = (string) 'Email'
G13 = (int) 1
G14 = (string) 'Added '
G15 = (string) ' from Dest...' (11 bytes)
G16 = (string) 'Items='
G17 = (string) '...' (1 bytes)
G18 = (string) 'From'
G19 = (string) 'Name'
G20 = (string) 'Find'
G21 = (string) ' '
G22 = (string) 'Sub'
G23 = (int) 2
G24 = (string) 'FirstName'
G25 = (string) 'SurName'
G26 = (string) 'Error: Couldn't save new contact....' (34 bytes)
G27 = (string) 'Error: Couldn't create contact....' (32 bytes)
G28 = (string) 'Error: No thing at index '
G29 = (string) '...' (1 bytes)
G30 = (string) 'Error: Failed to get current folder....' (37 bytes)
G31 = (string) 'Script took '
G32 = (string) ' ms...' (4 bytes)
G33 = (string) ' contacts'
G34 = (string) 'Script'
G35 = (string) 'Error: Failed to get source folder ''
G36 = (string) ''...' (2 bytes)
G37 = (string) 'Error: Couldn't get the current folder....' (40 bytes)
G38 = (int) 885
G39 = (string) 'AddSendersToContacts'
G40 = (string) 'Couldn't add hook for AddSendersToContacts'

00000000 Jump by 1424 (to 0x595)
AddSendersToContacts:
  8:
00000005 Assign L2 <- G0
  10:
0000000E R0 = L0->DomGet(G1, G2)
0000001F Assign L3 <- R0
  11:
00000028 R1 = L3->DomGet(G3, G2)
00000039 Assign R2 <- G4
00000042 Plus R2 += R1
0000004B Plus R2 += G5
00000054 Call: R0 = Print(R2)
  12:
00000063 JumpZ(L3) by 0x4cd
  14:
0000006C Call: L4 = SelectFolder(L0, L2)
  16:
0000007F JumpZ(L4) by 0x482
  18:
00000088 Call: L5 = Now()
  19:
00000093 Call: L6 = GetFolder(L4)
  20:
000000A2 R1 = L6->DomGet(G3, G2)
000000B3 Assign R2 <- G6
000000BC Plus R2 += R1
000000C5 Plus R2 += G7
000000CE Call: R0 = Print(R2)
  21:
000000DD JumpZ(L6) by 0x3a6
  23:
000000E6 Call: L7 = New(G8)
  26:
000000F5 Call: R0 = LoadFolder(L6)
  27:
00000104 R0 = L6->DomGet(G9, G2)
00000115 Assign L8 <- R0
  28:
0000011E Assign L9 <- G10
00000127 Assign R0 <- L9
00000130 R0 < L8
00000139 JumpZ(R0) by 0x66
  30:
00000142 R0 = L6->DomGet(G11, L9)
00000153 Assign L10 <- R0
  31:
0000015C R0 = L10->DomGet(G12, G2)
0000016D Assign L11 <- R0
  32:
00000176 JumpZ(L11) by 0xd
  34:
0000017F ArraySet L7[L11] = G13
0000018C Assign R0 <- L9
00000195 PostInc R0
0000019A Assign L9 <- R0
  38:
000001A3 Jump by -129 (to 0x127)
000001A8 Assign R1 <- G14
000001B1 Plus R1 += L8
000001BA Plus R1 += G15
000001C3 Call: R0 = Print(R1)
  39:
000001D2 Assign L12 <- G10
  42:
000001DB R1 = L3->DomGet(G9, G2)
000001EC Assign R2 <- G16
000001F5 Plus R2 += R1
000001FE Plus R2 += G17
00000207 Call: R0 = Print(R2)
  43:
00000216 R0 = L3->DomGet(G9, G2)
00000227 Assign L8 <- R0
  44:
00000230 Assign L9 <- G10
00000239 Assign R0 <- L9
00000242 R0 < L8
0000024B JumpZ(R0) by 0x233
  46:
00000254 R0 = L3->DomGet(G11, L9)
00000265 Assign L13 <- R0
  47:
0000026E JumpZ(L13) by 0x1ca
  49:
00000277 R0 = L13->DomGet(G18, G2)
00000288 R0 = R0->DomGet(G12, G2)
00000299 Assign L11 <- R0
  50:
000002A2 JumpZ(L11) by 0x191
  52:
000002AB ArrayGet R0 = L7[L11]
000002B8 R0 = !R0
000002BD JumpZ(R0) by 0x176
  54:
000002C6 ArraySet L7[L11] = G13
  56:
000002D3 Call: L10 = CreateThing(L2)
  57:
000002E2 JumpZ(L10) by 0x142
  59:
000002EB L10->DomSet(G12, G2) = L11
  61:
000002FC R0 = L13->DomGet(G18, G2)
0000030D R0 = R0->DomGet(G19, G2)
0000031E Assign L14 <- R0
  62:
00000327 R0 = L14->DomCall(G20, G21)
0000033C Assign L15 <- R0
  63:
00000345 Assign R0 <- L15
0000034E R0 < G10
00000357 JumpZ(R0) by 0x67
  65:
00000360 R0 = L14->DomCall(G22, G10, L15)
00000379 L10->DomSet(G24, G2) = R0
  66:
0000038A Assign R0 <- L15
00000393 Plus R0 += G13
0000039C R1 = L14->DomCall(G22, R0)
000003B1 L10->DomSet(G25, G2) = R1
  68:
000003C2 Jump by 17 (to 0x3d8)
  70:
000003C7 L10->DomSet(G24, G2) = L14
  73:
000003D8 Call: R1 = SaveThing(L6, L10)
000003EB R1 = !R1
000003F0 JumpZ(R1) by 0x14
  75:
000003F9 Call: R1 = Print(G26)
  77:
00000408 Jump by 27 (to 0x428)
  79:
0000040D Assign R1 <- L12
00000416 Plus R1 += G13
0000041F Assign L12 <- R1
  82:
00000428 Jump by 15 (to 0x43c)
0000042D Call: R1 = Print(G27)
  86:
0000043C Jump by 42 (to 0x46b)
00000441 Assign R2 <- G28
0000044A Plus R2 += L9
00000453 Plus R2 += G29
0000045C Call: R1 = Print(R2)
0000046B Assign R0 <- L9
00000474 PostInc R0
00000479 Assign L9 <- R0
  88:
00000482 Jump by -590 (to 0x239)
  89:
00000487 Jump by 15 (to 0x49b)
0000048C Call: R1 = Print(G30)
  91:
0000049B Call: L16 = Now()
  92:
000004A6 Assign R3 <- L16
000004AF Minus R3 -= L5
000004B8 Assign R4 <- G31
000004C1 Plus R4 += R3
000004CA Plus R4 += G32
000004D3 Plus R4 += G14
000004DC Plus R4 += L12
000004E5 Plus R4 += G33
000004EE Call: R1 = MsgBox(L0, R4, G34)
  95:
00000505 Jump by 42 (to 0x534)
0000050A Assign R3 <- G35
00000513 Plus R3 += L4
0000051C Plus R3 += G36
00000525 Call: R1 = Print(R3)
  97:
00000534 Jump by 15 (to 0x548)
00000539 Call: R1 = Print(G37)
  100:
00000548 Ret G2
Main:
  102:
0000054D Call: R3 = LoadString(G38)
0000055C Call: R1 = AddToolsMenuItem(R3, G39)
0000056F R1 = !R1
00000574 JumpZ(R1) by 0x13
  103:
0000057D Call: R1 = MsgBox(L0, G40)
  104:
00000590 Ret G13
