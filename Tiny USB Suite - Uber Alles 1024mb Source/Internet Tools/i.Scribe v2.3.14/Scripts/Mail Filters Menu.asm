G0 = (string) 'InternetHeader'
G1 = (string) 'List-Id'
G2 = (string) 'Length'
G3 = null
G4 = (string) 'Fin'
G5 = (string) '<'
G6 = (int) 1
G7 = (string) 'Find'
G8 = (string) '>'
G9 = (int) 2
G10 = (int) 0
G11 = (string) 'Sub'
G12 = (string) 'Select folder to filter mailing list into:'
G13 = (int) -1426128889
G14 = (string) 'Name'
G15 = (string) '<Conditions><And><Condition Not='0' Field='mail.InternetHeader[List-Id]' Op='Contains' Value=''
G16 = (string) ''/></And></Conditions>'
G17 = (string) 'ConditionsXml'
G18 = (string) '<Actions><Action Type='7' Arg1='false,notnew' /><Action Type='0' Arg1=''
G19 = (string) ''/></Actions>'
G20 = (string) 'ActionsXml'
G21 = (string) 'From'
G22 = (string) 'Email'
G23 = (string) '<Conditions><And><Condition Not='0' Field='mail.From.Email' Op='Contains' Value=''
G24 = (string) 'List'
G25 = (int) 6
G26 = (string) 'Item'
G27 = (string) 'Add'
G28 = (string) 'Sort'
G29 = (string) 'Index'
G30 = (int) 8
G31 = (string) '-UsedTs'
G32 = (string) 'GetAllGroups: No groups folder....' (32 bytes)
G33 = (int) 4000
G34 = (string) 'AddCondition'
G35 = (string) 'Mail.From.Email'
G36 = (string) '='
G37 = (int) 3
G38 = (string) 'Error: No filter for ID: '
G39 = (string) '...' (1 bytes)
G40 = (int) 5000
G41 = (string) 'AddAddress'
G42 = (string) 'Error: No group for ID: '
G43 = (string) '...' (1 bytes)
G44 = (int) -1426128895
G45 = (string) 'Type'
G46 = (string) '&Create Filter'
G47 = (int) -1
G48 = (string) 'New filter for email from mailing list ''
G49 = (string) '''
G50 = (string) 'CreateMailingListFilter'
G51 = (int) 3000
G52 = (string) 'New filter for email from ''
G53 = (string) 'CreateFromFilter'
G54 = (int) 3001
G55 = (string) 'Add ''
G56 = (string) '' to existing filter'
G57 = (string) '('
G58 = (string) ') '
G59 = (string) 'AddFromToFilter'
G60 = (string) '' to contact group'
G61 = (string) 'AddFromToGroup'
G62 = (string) 'OnThingContextMenu'
G63 = (string) 'CreateFilterMenu'
G64 = (string) 'Couldn't add CreateFilterMenu'

00000000 Jump by 2305 (to 0x906)
ExtractMailList:
  3:
00000005 R0 = L0->DomGet(G0, G1)
00000016 Assign L1 <- R0
  4:
0000001F Assign R0 <- L1
00000028 R0 = !R0
0000002D JumpZ(R0) by 0x5
  5:
00000036 Ret L1
  7:
0000003B R0 = L1->DomGet(G2, G3)
0000004C JumpZ(R0) by 0xc5
  9:
00000055 R0 = L1->DomCall(G4, G5)
0000006A Assign L2 <- R0
  10:
00000073 R0 = L1->DomCall(G7, G8, L2)
0000008C Assign L3 <- R0
  11:
00000095 Assign R0 <- L2
0000009E R0 < G10
000000A7 Assign R1 <- L3
000000B0 R1 < G10
000000B9 R0 && R1
000000C2 JumpZ(R0) by 0x4f
  13:
000000CB Assign R0 <- L2
000000D4 Plus R0 += G6
000000DD Assign R1 <- L3
000000E6 Minus R1 -= L2
000000EF Minus R1 -= G6
000000F8 R2 = L1->DomCall(G11, R0, R1)
00000111 Assign L1 <- R2
  17:
0000011A Ret L1
CreateMailingListFilter:
  22:
00000121 CallScript: L3 = 00000005(frame=4)(L1)
  23:
00000130 Call: L4 = BrowseFolder(L0, G12, L3)
  24:
00000147 R2 = L4->DomGet(G2, G3)
00000158 JumpZ(R2) by 0x87
  26:
00000161 Call: L5 = CreateThing(G13)
  27:
00000170 L5->DomSet(G14, G3) = L3
  28:
00000181 Assign R2 <- G15
0000018A Plus R2 += L3
00000193 Plus R2 += G16
0000019C L5->DomSet(G17, G3) = R2
  29:
000001AD Assign R2 <- G18
000001B6 Plus R2 += L4
000001BF Plus R2 += G19
000001C8 L5->DomSet(G20, G3) = R2
  30:
000001D9 Call: R2 = ShowThingWindow(L5)
  34:
000001E8 Ret G3
CreateFromFilter:
  36:
000001ED R2 = L1->DomGet(G21, G3)
000001FE R2 = R2->DomGet(G22, G3)
0000020F Assign L3 <- R2
  37:
00000218 Call: L4 = CreateThing(G13)
  38:
00000227 L4->DomSet(G14, G3) = L3
  39:
00000238 Assign R2 <- G23
00000241 Plus R2 += L3
0000024A Plus R2 += G16
00000253 L4->DomSet(G17, G3) = R2
  40:
00000264 Call: R2 = ShowThingWindow(L4)
  43:
00000273 Ret G3
GetSortedFilters:
  45:
00000278 Call: L0 = New(G24)
  46:
00000287 Call: L1 = GetFolder(G25)
  47:
00000296 JumpZ(L1) by 0xb8
  49:
0000029F R2 = L1->DomGet(G26, G3)
000002B0 R2 = R2->DomGet(G2, G3)
000002C1 Assign L2 <- R2
  50:
000002CA Assign L3 <- G10
000002D3 Assign R2 <- L3
000002DC R2 < L2
000002E5 JumpZ(R2) by 0x54
  52:
000002EE R2 = L1->DomGet(G26, L3)
000002FF Assign L4 <- R2
  53:
00000308 JumpZ(L4) by 0x15
  55:
00000311 R2 = L0->DomCall(G27, L4)
00000326 Assign R2 <- L3
0000032F PostInc R2
00000334 Assign L3 <- R2
  58:
0000033D Jump by -111 (to 0x2d3)
00000342 R2 = L0->DomCall(G28, G29)
  60:
00000357 Ret L0
GetAllGroups:
  65:
0000035C Call: L0 = New(G24)
  66:
0000036B Call: L1 = GetFolder(G30)
  67:
0000037A JumpZ(L1) by 0x77
  69:
00000383 Assign L2 <- G10
0000038C R2 = L1->DomGet(G26, L2)
0000039D Assign L3 <- R2
000003A6 JumpZ(R2) by 0x31
  71:
000003AF R2 = L0->DomCall(G27, L3)
000003C4 Assign R2 <- L2
000003CD PostInc R2
000003D2 Assign L2 <- R2
  73:
000003DB Jump by -84 (to 0x38c)
000003E0 R2 = L0->DomCall(G28, G31)
  75:
000003F5 Jump by 15 (to 0x409)
  77:
000003FA Call: R2 = Print(G32)
  80:
00000409 Ret L0
AddFromToFilter:
  85:
00000410 CallScript: L3 = 00000278(frame=5)()
  86:
0000041B Assign R2 <- L2
00000424 Minus R2 -= G33
0000042D ArrayGet R3 = L3[R2]
0000043A Assign L4 <- R3
  87:
00000443 JumpZ(L4) by 0x4d
  89:
0000044C R3 = L1->DomGet(G21, G3)
0000045D R3 = R3->DomGet(G22, G3)
0000046E Assign L5 <- R3
  90:
00000477 R3 = L4->DomCall(G34, G35, G36, L5)
  92:
00000494 Jump by 42 (to 0x4c3)
  94:
00000499 Assign R4 <- G38
000004A2 Plus R4 += L2
000004AB Plus R4 += G39
000004B4 Call: R3 = Print(R4)
  98:
000004C3 Ret G3
AddFromToGroup:
  100:
000004CA CallScript: L3 = 0000035C(frame=4)()
  101:
000004D5 Assign R3 <- L2
000004DE Minus R3 -= G40
000004E7 ArrayGet R4 = L3[R3]
000004F4 Assign L4 <- R4
  102:
000004FD JumpZ(L4) by 0x3c
  104:
00000506 R4 = L1->DomGet(G21, G3)
00000517 R4 = R4->DomGet(G22, G3)
00000528 R5 = L4->DomCall(G41, R4)
  106:
0000053D Jump by 42 (to 0x56c)
  108:
00000542 Assign R6 <- G42
0000054B Plus R6 += L2
00000554 Plus R6 += G43
0000055D Call: R5 = Print(R6)
  112:
0000056C Ret G3
CreateFilterMenu:
  114:
00000571 R5 = L1->DomGet(G45, G3)
00000582 R5 == G44
0000058B JumpZ(R5) by 0x334
  116:
00000594 R5 = L2->DomGet(G2, G3)
000005A5 Minus R5 -= G9
000005AE Call: L3 = GMenuAddSubmenu(L2, G46, R5)
  117:
000005C5 JumpZ(L3) by 0x2fa
  120:
000005D0 CallScript: L4 = 00000005(frame=4)(L1)
  121:
000005DF JumpZ(L4) by 0x58
  123:
000005E8 R5 = L4->DomGet(G2, G3)
000005F9 JumpZ(R5) by 0x3e
  125:
00000602 Assign R6 <- G48
0000060B Plus R6 += L4
00000614 Plus R6 += G49
0000061D Call: R5 = GMenuAddItem(L3, G47, R6, G47, G50, G51)
  129:
00000640 R5 = L1->DomGet(G21, G3)
00000651 R5 = R5->DomGet(G22, G3)
00000662 Assign L5 <- R5
  131:
0000066B Assign R6 <- G52
00000674 Plus R6 += L5
0000067D Plus R6 += G49
00000686 Call: R5 = GMenuAddItem(L3, G47, R6, G47, G53, G54)
  132:
000006A9 Assign R5 <- G55
000006B2 Plus R5 += L5
000006BB Plus R5 += G56
000006C4 Call: L6 = GMenuAddSubmenu(L3, R5, G47)
  133:
000006DB JumpZ(L6) by 0xef
  135:
000006E6 CallScript: L7 = 00000278(frame=5)()
  136:
000006F1 Assign L8 <- G10
000006FA R5 = L7->DomGet(G2, G3)
0000070B Assign R6 <- L8
00000714 R6 < R5
0000071D JumpZ(R6) by 0xad
  138:
00000726 ArrayGet R5 = L7[L8]
00000733 Assign L9 <- R5
  139:
0000073C R6 = L9->DomGet(G29, G3)
0000074D Assign R7 <- G57
00000756 Plus R7 += R6
0000075F Plus R7 += G58
00000768 R6 = L9->DomGet(G14, G3)
00000779 Plus R7 += R6
00000782 Assign R6 <- G33
0000078B Plus R6 += L8
00000794 Call: R5 = GMenuAddItem(L6, G47, R7, G47, G59, R6)
000007B7 Assign R5 <- L8
000007C0 PostInc R5
000007C5 Assign L8 <- R5
  141:
000007CE Jump by -217 (to 0x6fa)
  143:
000007D3 Assign R5 <- G55
000007DC Plus R5 += L5
000007E5 Plus R5 += G60
000007EE Call: L10 = GMenuAddSubmenu(L3, R5, G47)
  144:
00000805 JumpZ(L10) by 0xba
  146:
00000810 CallScript: L7 = 0000035C(frame=4)()
  147:
0000081B Assign L8 <- G10
00000824 R5 = L7->DomGet(G2, G3)
00000835 Assign R6 <- L8
0000083E R6 < R5
00000847 JumpZ(R6) by 0x78
  149:
00000850 ArrayGet R5 = L7[L8]
0000085D Assign L11 <- R5
  150:
00000866 R6 = L11->DomGet(G14, G3)
00000877 Assign R7 <- G40
00000880 Plus R7 += L8
00000889 Call: R5 = GMenuAddItem(L10, G47, R6, G47, G61, R7)
000008AC Assign R5 <- L8
000008B5 PostInc R5
000008BA Assign L8 <- R5
  152:
000008C3 Jump by -164 (to 0x824)
  157:
000008C8 Ret G3
Main:
  159:
000008CD Call: R5 = AddCallback(G62, G63)
000008E0 R5 = !R5
000008E5 JumpZ(R5) by 0x13
  160:
000008EE Call: R5 = MsgBox(L0, G64)
  162:
00000901 Ret G6
