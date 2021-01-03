G0 = (string) 'CurrentFolder'
G1 = null
G2 = (string) 'Not a mail folder.'
G3 = (string) 'Name'
G4 = (int) -1426128895
G5 = (string) 'ItemType'
G6 = (int) 0
G7 = (string) 'Length'
G8 = (string) 'Item'
G9 = (string) 'Attachments'
G10 = (string) 'Attachment'
G11 = (int) 769
G12 = (int) 4
G13 = (int) 6
G14 = (string) 'User response: '
G15 = (string) 'No attachments to delete'
G16 = (string) 'Type'
G17 = (string) 'Not a mail folder: '
G18 = (int) 1266
G19 = (string) 'DeleteAttachments'
G20 = (string) 'Couldn't add hook for DeleteAttachments'
G21 = (int) 1

00000000 Jump by 1110 (to 0x45b)
DeleteAttachments:
  11:
00000005 R0 = L0->DomGet(G0, G1)
00000016 Assign L1 <- R0
  13:
0000001F Assign R0 <- L1
00000028 R0 = !R0
0000002D JumpZ(R0) by 0x2d
  15:
00000036 R1 = L0->DomGet(G3, G1)
00000047 Call: R0 = MsgBox(L0, G2, R1)
  17:
0000005E Jump by 939 (to 0x40e)
00000063 R0 = L1->DomGet(G5, G1)
00000074 R0 == G4
0000007D JumpZ(R0) by 0x33d
  19:
00000086 Assign L2 <- G6
  20:
0000008F Assign L3 <- G6
  21:
00000098 R0 = L1->DomGet(G7, G1)
000000A9 Assign L4 <- R0
  23:
000000B2 Assign L5 <- G6
000000BB Assign R0 <- L5
000000C4 R0 < L4
000000CD JumpZ(R0) by 0xff
  25:
000000D6 R0 = L1->DomGet(G8, L5)
000000E7 Assign L6 <- R0
  26:
000000F0 JumpZ(L6) by 0xc0
  28:
000000F9 R0 = L6->DomGet(G9, G1)
0000010A Assign L7 <- R0
  29:
00000113 Assign L8 <- G6
0000011C Assign R0 <- L8
00000125 R0 < L7
0000012E JumpZ(R0) by 0x82
  31:
00000137 R0 = L6->DomGet(G10, L8)
00000148 Assign L9 <- R0
  32:
00000151 JumpZ(L9) by 0x43
  34:
0000015A R0 = L9->DomGet(G7, G1)
0000016B Assign R1 <- L2
00000174 Plus R1 += R0
0000017D Assign L2 <- R1
  35:
00000186 Assign R0 <- L3
0000018F PostInc R0
00000194 Assign L3 <- R0
0000019D Assign R0 <- L8
000001A6 PostInc R0
000001AB Assign L8 <- R0
  38:
000001B4 Jump by -157 (to 0x11c)
000001B9 Assign R0 <- L5
000001C2 PostInc R0
000001C7 Assign L5 <- R0
  41:
000001D0 Jump by -282 (to 0xbb)
000001D5 JumpZ(L3) by 0x1b8
  43:
000001DE Call: R0 = LoadString(G11)
000001ED Call: R1 = FormatSize(L2)
000001FC Call: L10 = Sprintf(R0, L3, R1)
  44:
00000213 R0 = L0->DomGet(G3, G1)
00000224 Call: L11 = MsgBox(L0, L10, R0, G12)
  45:
0000023F Assign R0 <- L11
00000248 R0 == G13
00000251 JumpZ(R0) by 0x116
  47:
0000025A Assign L5 <- G6
00000263 Assign R0 <- L5
0000026C R0 < L4
00000275 JumpZ(R0) by 0xed
  49:
0000027E R0 = L1->DomGet(G8, L5)
0000028F Assign L6 <- R0
  51:
00000298 JumpZ(L6) by 0xae
  54:
000002A1 Assign L8 <- G6
  55:
000002AA R0 = L6->DomGet(G9, G1)
000002BB R0 < L8
000002C4 JumpZ(R0) by 0x82
  57:
000002CD R0 = L6->DomGet(G9, G1)
000002DE Assign L12 <- R0
  58:
000002E7 R0 = L6->DomGet(G10, L8)
000002F8 Assign L9 <- R0
  59:
00000301 Call: R0 = DeleteThing(L9)
  60:
00000310 R0 = L6->DomGet(G9, G1)
00000321 R0 == L12
0000032A JumpZ(R0) by 0x17
  61:
00000333 Assign R0 <- L8
0000033C PostInc R0
00000341 Assign L8 <- R0
  63:
0000034A Jump by -165 (to 0x2aa)
0000034F Assign R0 <- L5
00000358 PostInc R0
0000035D Assign L5 <- R0
  65:
00000366 Jump by -264 (to 0x263)
  66:
0000036B Jump by 33 (to 0x391)
  68:
00000370 Assign R1 <- G14
00000379 Plus R1 += L11
00000382 Call: R0 = Print(R1)
  71:
00000391 Jump by 40 (to 0x3be)
  73:
00000396 R1 = L0->DomGet(G3, G1)
000003A7 Call: R0 = MsgBox(L0, G15, R1)
  76:
000003BE Jump by 75 (to 0x40e)
  78:
000003C3 R1 = L1->DomGet(G16, G1)
000003D4 Assign R2 <- G17
000003DD Plus R2 += R1
000003E6 R1 = L0->DomGet(G3, G1)
000003F7 Call: R0 = MsgBox(L0, R2, R1)
  82:
0000040E Ret G1
Main:
  84:
00000413 Call: R1 = LoadString(G18)
00000422 Call: R0 = AddToolsMenuItem(R1, G19)
00000435 R0 = !R0
0000043A JumpZ(R0) by 0x13
  85:
00000443 Call: R0 = MsgBox(L0, G20)
  86:
00000456 Ret G21
