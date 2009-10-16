#############################################################################
##
#W  simplegroupslist.g              GAP library                   Stefan Kohl
##
#H  @(#)$Id: simplegroupslist.g,v 4.3 2007/07/05 09:30:56 stefan Exp $
##
#Y  Copyright (C) 2007 The GAP Group
##
##  This file contains a list of all 56 nonabelian simple groups of order
##  less than 1000000, sorted by ascending order.
##
Revision.simplegroupslist_g :=
    "@(#)$Id: simplegroupslist.g,v 4.3 2007/07/05 09:30:56 stefan Exp $";

BindGlobal( "SMALL_NONABELIAN_SIMPLE_GROUPS", [
AlternatingGroup(5), PSL(3,2), AlternatingGroup(6), PSL(2,8),
Group([ ( 1, 2)( 4, 5)( 6, 8)( 7, 9), ( 2, 3, 4)( 5, 6, 7)( 8,10,11) ]),
PSL(2,13), PSL(2,17), AlternatingGroup(7), PSL(2,19), PSL(2,16), PSL(3,3),
Group([ ( 2, 4)( 3, 6)( 5, 9)( 7,12)( 8,13)(10,17)(14,19)(15,20)(16,21)(18,24)
    (22,26)(23,27), ( 1, 2, 5,10, 7, 3)( 4, 8,14,12,11, 6)( 9,15,19,21,22,16)
    (13,17,23,28,25,18)(24,26,27) ]),
PSL(2,23), PSL(2,25), MathieuGroup(11), PSL(2,27), PSL(2,29),
PSL(2,31), AlternatingGroup(8), PSL(3,4), PSL(2,37), 
Group([ ( 1, 2)( 3, 5)( 4, 7)( 6, 9)( 8,11)(10,13)(12,17)(15,20)(16,18)(19,23)
    (21,24)(22,26), ( 2, 3, 6, 8, 4)( 7, 9,12,14,10)(11,15,21,22,16)
    (13,18,24,25,19)(17,23,27,26,20) ]), Sz(IsPermGroup,8), PSL(2,32),
PSL(2,41), PSL(2,43), PSL(2,47), PSL(2,49),
Group([ ( 1, 2)( 3, 7)( 4, 8)( 5, 9)( 6,10)(11,19)(12,20)(13,21)(14,22)(15,23)
    (16,24)(17,25)(18,26)(27,30)(28,36)(29,37)(32,38)(33,39)(34,40)(35,41)
    (42,51)(43,48)(44,52)(45,50)(46,53)(47,54)(49,55)(56,59)(57,60)(58,61)
    (62,63)(64,65), ( 1, 3, 4)( 2, 5, 6)( 7,11,12)( 8,13,14)( 9,15,16)
    (10,17,18)(20,27,28)(21,29,30)(23,26,31)(24,32,33)(25,34,35)(36,37,42)
    (38,43,44)(39,45,46)(40,47,48)(41,49,50)(51,55,52)(53,56,57)(54,58,59)
    (60,62,63)(61,64,65) ]),
PSL(2,53), MathieuGroup(12), PSL(2,59), PSL(2,61),
Group([ ( 1, 2)( 4, 9)( 5, 6)( 8,17)(10,20)(11,21)(12,15)(13,24)(14,19)(16,23)
    (18,32)(22,37)(25,43)(26,45)(28,36)(30,33)(31,35)(39,40)(47,49)(48,50), 
    ( 2, 3, 4, 6)( 5,11,15, 7)( 8,18,19, 9)(10,17)(12,22,38,23)(13,25,36,21)
    (14,26,39,24)(16,29,35,20)(27,28,46,37)(30,32)(31,47,45,34)(40,42)
    (41,44,50,43)(48,49), ( 1, 3, 4, 8,10,16,12, 7, 5, 2)( 6,11,13,14, 9)
    (15,22,27,28,21)(17,18,30,33,32,19,26,34,31,20)(23,29,35,47,48,43,36,46,
     37,38)(24,25,41,44,50,49,45,39,42,40), ( 1, 4,10,12, 5)( 2, 3, 8,16, 7)
    ( 6,13, 9,11,14)(15,27,21,22,28)(17,30,32,26,31)(18,33,19,34,20)
    (23,35,48,36,37)(24,41,50,45,42)(25,44,49,39,40)(29,47,43,46,38) ]),
PSL(2,67),
Group([ (  1,  2)(  3,  5)(  6,  8)(  7,  9)( 10, 11)( 12, 14)( 13, 15)
    ( 16, 19)( 17, 20)( 18, 21)( 22, 26)( 23, 27)( 24, 28)( 25, 29)( 30, 38)
    ( 31, 39)( 32, 40)( 33, 34)( 35, 41)( 36, 42)( 37, 43)( 44, 53)( 45, 54)
    ( 46, 55)( 47, 56)( 48, 57)( 49, 58)( 50, 59)( 51, 60)( 52, 61)( 62, 80)
    ( 63, 81)( 64, 82)( 65, 83)( 66, 84)( 67, 68)( 69, 85)( 70, 86)( 71, 87)
    ( 72, 88)( 73, 89)( 74, 90)( 75, 76)( 77, 91)( 79, 92)( 93,115)( 94,116)
    ( 95,117)( 96, 97)( 98,118)( 99,119)(100,120)(101,121)(102,122)(103,123)
    (104,124)(105,125)(106,126)(107,127)(108,128)(109,129)(110,130)(111,131)
    (112,132)(113,133)(114,134)(135,158)(136,164)(137,165)(138,166)(139,167)
    (140,168)(143,169)(144,170)(145,171)(146,172)(147,173)(148,149)(150,174)
    (151,175)(152,176)(154,177)(155,178)(156,179)(157,180)(159,181)(160,162)
    (163,182)(183,206)(184,207)(185,208)(186,209)(187,210)(188,211)(189,190)
    (191,212)(192,213)(193,214)(194,215)(195,216)(196,217)(198,218)(199,219)
    (200,201)(202,220)(203,221)(204,222)(205,223)(224,244)(225,226)(227,233)
    (228,230)(231,232)(234,243)(235,245)(236,246)(237,247)(238,248)(239,249)
    (240,250)(241,251)(242,252)(253,260)(254,261)(255,262)(256,263)(257,258)
    (259,264), (  2,  3,  4)(  5,  6,  7)(  8,  9, 10)( 11, 12, 13)
    ( 14, 16, 17)( 15, 18, 19)( 20, 22, 23)( 21, 24, 25)( 26, 30, 31)
    ( 27, 32, 33)( 28, 34, 35)( 29, 36, 37)( 38, 43, 44)( 39, 45, 46)
    ( 40, 47, 48)( 41, 49, 50)( 42, 51, 52)( 53, 62, 63)( 54, 64, 65)
    ( 55, 66, 67)( 56, 68, 69)( 57, 70, 71)( 58, 72, 73)( 59, 74, 75)
    ( 60, 76, 77)( 61, 78, 79)( 80, 93, 94)( 81, 95, 96)( 82, 97, 98)
    ( 83, 99,100)( 84,101,102)( 85,103,104)( 86,105,106)( 87,107, 88)
    ( 89,108,109)( 90,110,111)( 91,112,113)( 92,114,115)(116,130,135)
    (117,136,137)(118,138,139)(119,140,141)(120,121,142)(122,143,144)
    (123,145,146)(124,147,148)(125,149,150)(126,151,152)(127,153,154)
    (128,155,156)(129,157,158)(131,159,160)(132,161,162)(133,163,134)
    (164,180,183)(165,184,185)(166,186,187)(167,188,189)(168,190,169)
    (170,191,171)(172,192,193)(173,194,195)(174,196,197)(175,198,199)
    (176,200,177)(178,201,202)(179,203,204)(181,182,205)(206,224,225)
    (208,226,209)(210,215,227)(211,228,229)(212,230,231)(214,232,233)
    (216,234,235)(217,236,218)(219,237,238)(220,239,240)(221,241,242)
    (222,243,244)(245,253,246)(247,254,252)(248,255,249)(250,256,257)
    (251,258,259)(260,261,265)(262,266,264) ]), PSL(2,71),
AlternatingGroup(9), PSL(2,73), PSL(2,79), PSL(2,64), PSL(2,81), PSL(2,83),
PSL(2,89), PSL(3,5), MathieuGroup(22), PSL(2,97), PSL(2,101), PSL(2,103), 
Group([ (  1,  2)(  3,  4)(  5,  9)(  6, 11)(  7, 13)(  8, 14)( 12, 19)
    ( 16, 25)( 17, 27)( 18, 29)( 20, 32)( 21, 34)( 22, 36)( 23, 38)( 26, 40)
    ( 28, 43)( 31, 47)( 33, 51)( 37, 56)( 39, 57)( 42, 60)( 45, 55)( 46, 65)
    ( 49, 67)( 50, 69)( 52, 71)( 54, 74)( 58, 77)( 62, 78)( 64, 79)( 66, 72)
    ( 68, 83)( 70, 84)( 73, 85)( 75, 81)( 82, 88)( 87, 91)( 89, 96)( 90, 99)
    ( 92,100), (  1,  3,  7,  8,  4)(  2,  5, 10, 12,  6)(  9, 15, 24, 26, 16)
    ( 11, 17, 28, 25, 18)( 13, 20, 33, 35, 21)( 14, 22, 37, 39, 23)
    ( 19, 30, 46, 48, 31)( 27, 41, 59, 61, 42)( 29, 44, 63, 64, 45)
    ( 32, 49, 68, 70, 50)( 34, 52, 72, 73, 53)( 36, 54, 58, 40, 55)
    ( 38, 51, 43, 62, 57)( 47, 60, 71, 81, 66)( 56, 75, 87, 88, 76)
    ( 65, 69, 67, 82, 80)( 74, 83, 94, 98, 86)( 77, 89, 93, 79, 90)
    ( 78, 91,100, 99, 92)( 84, 95, 85, 97, 96) ]), PSL(2,107), PSL(2,109),
PSL(2,113), PSL(2,121), PSL(2,125),
Group([ ( 1, 2)( 3, 7)( 5,10)( 6,12)( 8,16)( 9,17)(11,20)(13,23)(18,30)(19,26)
    (21,28)(24,39)(27,41)(31,47)(32,48)(33,49)(34,51)(35,53)(36,54)(37,55)
    (42,52)(43,56)(44,59)(45,60)(50,62)(57,68)(58,70)(61,74)(67,75)(69,76)
    (72,77)(80,82), ( 1, 3, 8, 9, 4)( 2, 5,11,13, 6)( 7,14,24,25,15)
    (10,18,31,32,19)(12,21,35,36,22)(16,26,40,42,27)(17,28,43,44,29)
    (20,33,50,52,34)(23,37,56,57,38)(30,45,61,49,46)(39,58,71,59,41)
    (47,62,70,68,54)(48,63,53,67,64)(51,65,69,55,66)(60,72,76,78,73)
    (74,79,81,75,80)(77,82,84,85,83) ]) ] );

#############################################################################
##
#E  simplegroupslist.g . . . . . . . . . . . . . . . . . . . . . .  ends here