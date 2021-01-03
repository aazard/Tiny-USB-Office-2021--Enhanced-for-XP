G0 = (string) 'CurrentFolder'
G1 = null
G2 = (int) -1426128895
G3 = (string) 'ItemType'
G4 = (string) 'HashTable'
G5 = (string) 'List'
G6 = (string) 'Length'
G7 = (int) 0
G8 = (string) 'Item'
G9 = (string) 'MessageID'
G10 = (string) 'DateReceived'
G11 = (int) -1
G12 = (string) 'No msgid at '
G13 = (string) '...' (1 bytes)
G14 = (string) 'No item at '
G15 = (string) '...' (1 bytes)
G16 = (int) 6
G17 = (int) 1013
G18 = (string) 'Name'
G19 = (int) 4
G20 = (string) 'Error: No dupes....' (17 bytes)
G21 = (string) 'Error: No folder....' (18 bytes)
G22 = (int) 911
G23 = (string) 'DeleteDuplicateMessages'
G24 = (string) 'Couldn't add hook for DeleteDuplicateMessages'
G25 = (int) 1

00000000 Jump by 900 (to 0x389)
DeleteDuplicateMessages:
  9:
00000005 R0 = L0->DomGet(G0, G1)
00000016 Assign L1 <- R0
  10:
0000001F R0 = L1->DomGet(G3, G1)
00000030 R0 == G2
00000039 Assign R1 <- L1
00000042 R1 && R0
0000004B JumpZ(R1) by 0x2d9
  12:
00000054 Call: L2 = New(G4)
  13:
00000063 Call: L3 = New(G5)
  14:
00000072 R0 = L1->DomGet(G6, G1)
00000083 Assign L4 <- R0
  16:
0000008C Assign L5 <- G7
00000095 Assign R0 <- L5
0000009E R0 < L4
000000A7 JumpZ(R0) by 0x163
  18:
000000B0 R0 = L1->DomGet(G8, L5)
000000C1 Assign L6 <- R0
  19:
000000CA JumpZ(L6) by 0xfa
  21:
000000D3 R0 = L6->DomGet(G9, G1)
000000E4 Assign L7 <- R0
  22:
000000ED Assign R0 <- L7
000000F6 R0 != G1
000000FF JumpZ(R0) by 0x96
  24:
00000108 ArrayGet R0 = L2[L7]
00000115 Assign L8 <- R0
  25:
0000011E JumpZ(L8) by 0x65
  28:
00000127 R0 = L8->DomGet(G10, G1)
00000138 R1 = L6->DomGet(G10, G1)
00000149 R1 < R0
00000152 JumpZ(R1) by 0x1f
  31:
0000015B ArraySet L3[G11] = L8
  32:
00000168 ArraySet L2[L7] = L6
  34:
00000175 Jump by 13 (to 0x187)
  37:
0000017A ArraySet L3[G11] = L6
  40:
00000187 Jump by 13 (to 0x199)
  42:
0000018C ArraySet L2[L7] = L6
  45:
00000199 Jump by 42 (to 0x1c8)
0000019E Assign R1 <- G12
000001A7 Plus R1 += L5
000001B0 Plus R1 += G13
000001B9 Call: R0 = Print(R1)
  47:
000001C8 Jump by 42 (to 0x1f7)
000001CD Assign R1 <- G14
000001D6 Plus R1 += L5
000001DF Plus R1 += G15
000001E8 Call: R0 = Print(R1)
000001F7 Assign R0 <- L5
00000200 PostInc R0
00000205 Assign L5 <- R0
  50:
0000020E Jump by -382 (to 0x95)
00000213 R0 = L3->DomGet(G6, G1)
00000224 R0 < G7
0000022D JumpZ(R0) by 0xe3
  52:
00000236 Call: R2 = LoadString(G17)
00000245 R3 = L3->DomGet(G6, G1)
00000256 Call: R1 = Sprintf(R2, R3)
00000269 R2 = L0->DomGet(G18, G1)
0000027A Call: R0 = MsgBox(L0, R1, R2, G19)
00000295 R0 == G16
0000029E JumpZ(R0) by 0x6d
  54:
000002A7 Assign L5 <- G7
000002B0 R0 = L3->DomGet(G6, G1)
000002C1 Assign R1 <- L5
000002CA R1 < R0
000002D3 JumpZ(R1) by 0x38
  56:
000002DC ArrayGet R1 = L3[L5]
000002E9 Call: R0 = DeleteThing(R1)
000002F8 Assign R0 <- L5
00000301 PostInc R0
00000306 Assign L5 <- R0
  58:
0000030F Jump by -100 (to 0x2b0)
  60:
00000314 Jump by 15 (to 0x328)
00000319 Call: R0 = Print(G20)
  62:
00000328 Jump by 15 (to 0x33c)
0000032D Call: R0 = Print(G21)
  65:
0000033C Ret G1
Main:
  67:
00000341 Call: R1 = LoadString(G22)
00000350 Call: R0 = AddToolsMenuItem(R1, G23)
00000363 R0 = !R0
00000368 JumpZ(R0) by 0x13
  68:
00000371 Call: R0 = MsgBox(L0, G24)
  69:
00000384 Ret G25
