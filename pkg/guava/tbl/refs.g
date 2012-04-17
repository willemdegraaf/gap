#############################################################################
##
#A  refs.g                  GUAVA library                       Reinald Baart
#A                                                       & Jasper Cramwinckel
#A                                                          & Erik Roijackers
##
##  This file contains a record, which fields are references used in the
##  tables.
##
#H  @(#)$Id: refs.g,v 1.3 2004/12/20 21:26:08 gap Exp $
##
#Y  Copyright (C)  1994,  Vakgroep Algemene Wiskunde,  T.U. Delft,  Nederland
##
#H  $Log: refs.g,v $
#H  Revision 1.3  2004/12/20 21:26:08  gap
#H  Added release 2 by David Joyner. AH
#H
#H  Revision 1.1.1.1  1998/03/19 17:31:43  lea
#H  Initial version of GUAVA for GAP4.  Development still under way. 
#H  Lea Ruscio 19/3/98
#H
#H
#H  Revision 1.2  1997/01/20 15:34:33  werner
#H  Upgrade from Guava 1.2 to Guava 1.3 for GAP release 3.4.4.
#H
#H  Revision 1.2  1994/11/10  14:34:24  rbaart
#H  Removed spaces
#H
#H  Revision 1.1  1994/11/10  14:29:23  rbaart
#H  Initial revision
#H
##
GUAVA_REF_LIST := rec(
ask := ["%T this reference is unknown, for more info",
        "%T contact A.E. Brouwer (aeb@cwi.nl)"],

Al := ["%A W.O. Alltop",
       "%T Binary codes with improved minimum weights",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-22",
       "%P 241-243",
       "%D Mar. 1976"],

Al2 := ["%A W.O. Alltop",
        "%T A method for extending binary linear codes",
        "%J IEEE Trans. Inform. Theory",
        "%V IT-30",
        "%P 871-872",
        "%D Nov. 1984"],

BM := ["%A L.D. Baumert",
       "%A R.J. McEliece ",
       "%T A note on the Griesmer bound",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-19",
       "%P 134-135",
       "%D Jan. 1973"],

Bv := ["%A B.I. Belov",
       "%T A conjecture on the Griesmer bound",
       "%J Optimization Methods and Their Applications",
       "%O (Russian)",
       "%D 1974"],

O := ["%A E.R. Berlekamp",
      "%B Algebraic coding theory",
      "%C New York",
      "%I McGraw-Hill",
      "%D 1968"],

S := ["%A E.R. Berlekamp",
      "%B Algebraic coding theory",
      "%C New York",
      "%I McGraw-Hill",
      "%D 1968"],

AEB := ["%A A.E. Brouwer",
        "%T The linear programming bound for binary linear codes",
        "%J IEEE Trans. Inform. Th.",
        "%V 39",
        "%D 1993",
        "%P 677-680"],

Joplus := ["%A A.E. Brouwer",
        "%T The linear programming bound for binary linear codes",
        "%J IEEE Trans. Inform. Th.",
        "%V 39",
        "%D 1993",
        "%P 677-680"],

CDJ := ["%A Huy T. Cao",
        "%A Randall L. Dougherty",
        "%A Heeralal Janwa",
        "%T A [55,16,19] binary Goppa code and related codes",
        "having large minimum distance",
        "%J IEEE Trans. Inform. Theory",
        "%V 37",
        "%P 1432",
        "%D Sep. 1991",
        "%X There is a [60,17,20] code."],

N := ["%A C.L. Chen",
      "%T Computer results on the minimum distance of some binary cyclic codes",
      "%J IEEE Trans. Inform. Theory",
      "%V IT-16",
      "%P 359-360",
      "%D May 1970"],

Ch2 := ["%A C.L. Chen",
        "%T Construction of some binary linear codes of minimum distance five",
        "%J IEEE Trans. Inform. Theory",
        "%V 37",
        "%D Sep 1991",
        "%P 1429",
        "%X There are [47,36,5], [33,23,5] and [79,66,5] codes."],

Ch := ["%A Y. Cheng",
       "%T New linear codes constructed by concatenating, extending,",
       "and shortening methods",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-33",
       "%P 719-721",
       "%D Sept. 1987"],

CS := ["%A Y. Cheng",
       "%A N.J.A. Sloane",
       "%T Codes from symmetry groups",
       "%J SIAM J. Discrete Math.",
       "%V 2",
       "%P 28-37",
       "%D 1989"],

CC := ["%A R.T. Chien",
       "%A D.M. Choy",
       "%T Algebraic generalization of BCH-Goppa-Helgert codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-21",
       "%P 70-79",
       "%D Jan. 1975"],

CLS := ["%A J.H. Conway",
       "%A S.J. Lomonaco Jr.",
       "%A N.J.A. Sloane",
       "%T A $[45,13]$ code with minimal distance 16",
       "%J Discrete Math.",
       "%V 83",
       "%P 213-217",
       "%D 1990"],

CZ := ["%A Chen Zhi",
       "%R email comm.",
       "%D Aug-Dec 1993"],

DK := ["%A R.N. Daskalov",
       "%A S.N. Kapralov",
       "%T New minimum distance bounds for certain binary linear codes",
       "%J IEEE Trans. Inform. Th.",
       "%V 38",
       "%P 1795-1796",
       "%D Nov. 1992"],

Das := ["%A R.N. Daskalov",
       "%T There is no binary linear [66,13,28] code",
       "%R preprint",
       "%D May 1992"],

#["%A S.M. Dodunekov",
#"%A S.B. Encheva",
#"%T New bounds on linear binary codes of dimension nine",
#"%B Proc. Fourth Joint Swedish-Soviet International Workshop on Information",
#"Theory, Gotland, Sweden, 1989",
#"%P 280-282"],

DEI := ["%A S.M. Dodunekov",
       "%A S.B. Encheva",
       "%A A.I. Ivanov",
       "%T New bounds on the minimum length of binary linear block codes",
       "%R Report LiTH-ISY-I-1283, Link\*(:oping Univ., Sweden",
       "%D 11 Nov. 1991"],

DM := ["%A S.M. Dodunekov",
       "%A N.L. Manev",
       "%T An improvement of the Griesmer bound for some small minimum distances",
       "%J Discr. Appl. Math.",
       "%V 12",
       "%P 103-114",
       "%D Oct. 1985"],

#["%A S.M. Dodunekov",
#"%A N.L. Manev",
#"%T An improvement of the Griesmer bound for some classes of distances",
#"%J Probl. Inform. Transm.",
#"%V 23",
#"%D 1987",
#"%P 38-46",
#"%X No [122,8,60] or [119,8,58] or [91,8,44] codes exist. (Also in {HY}.)"],

DH := ["%A S.M. Dodunekov",
       "%A T. Helleseth",
       "%A N. Manev",
       "%A \O. Ytrehus",
       "%T New bounds on binary linear codes of dimension eight",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-33",
       "%P 917-919",
       "%D Nov. 1987",
       "%X There exist [36,8,16], [58,8,26], [65,8,30], [75,8,34],",
       "[78,8,36], [90,8,42], [109,8,52], [99,8,48], [115,8,56] codes;",
       "no [67,8,32] exists."],

DJ := ["%A R. Dougherty",
       "%A H. Janwa",
       "%T Covering radius computations for binary cyclic codes",
       "%J Math. Comput.",
       "%V 57",
       "%D July 1991",
       "%P 415-434"],

FB := ["%A P. Farka\*(Vs",
       "%A K. Br\*(:uhl",
       "%T Three best binary linear block codes of minimum distance fifteen",
       "%J IEEE Trans. Inf. Th. (submitted)",
       "%D 1993"],

#["%A P.G. Farrell",
#"%T An introduction to anti-codes",
#"%B Algebraic coding theory and applications",
#"%E G. Longo",
#"%S CISM Courses and Lectures",
#"%N No. 258",
#"%C New York",
#"%I Springer-Verlag",
#"%D 1979"],

FP := ["%A A.B. Fontaine",
       "%A W.W. Peterson",
       "%T Group code equivalence and optimum codes",
       "%J IEEE Trans. Inform. Theory (Spec. Suppl.)",
       "%V IT-5",
       "%P 60-70",
       "%D May 1959"],

T := ["%A J.M. Goethals",
       "%T Analysis of weight distribution in binary cyclic codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-12",
       "%P 401-402",
       "%D July 1966"],

E := ["%A J.H. Griesmer",
       "%T A bound for error-correcting codes",
       "%J IBM J. Res. Develop.",
       "%V 4",
       "%P 532-542",
       "%D 1960"],

Gr := ["%A J.H. Griesmer",
       "%T A bound for error-correcting codes",
       "%J IBM J. Res. Develop.",
       "%V 4",
       "%P 532-542",
       "%D 1960"],

GG := ["%A B. Groneick",
       "%A S. Grosse",
       "%R priv. comm. and comm. via W. Scharlau",
       "%D July 1992"],

GG1 := ["%A B. Groneick",
       "%A S. Grosse",
       "%R priv. comm. and comm. via W. Scharlau",
       "%D July 1992"],

Gu := ["%A A. Gulliver",
       "%R priv. comm.",
       "%D July 1988"],

Gu3 := ["%A A. Gulliver",
       "%R priv. comm.",
       "%D Feb. 1993"],

GB := ["%A T. Aaron Gulliver",
       "%A Vijay K. Bhargava",
       "%T Some best rate $1/p$ and rate $(p-1)/p$ systematic quasi-cyclic codes",
       "%J IEEE Trans. Inform. Theory",
       "%V 37",
       "%D May 1991",
       "%P 552-555",
       "%X There exist [84,12,34], [99,11,43], [104,13,43], [108,12,46],",
       "[100,10,44], [110,11,48], [99,9,46], [110,10,49], [108,9,50],",
       "[117,9,55], [126,9,59], [44,33,5], [90,15,34], [104,26,30] codes."],

GB2 := ["%A T. Aaron Gulliver",
       "%A Vijay K. Bhargava",
       "%T Nine good rate $(m-1)/p m$ quasi-cyclic codes",
       "%J IEEE Trans. Inform. Th.",
       "%V 38",
       "%D July 1991",
       "%P 1366-1369"],

#["%A Noboru Hamada",
#"%T The nonexistence of [303,6,201;3]-codes meeting the Griesmer bound",
#"and some improvements on the bounds for $n sub 3 (6,d)$ ($1 <= d <= 243$)",
#"%R preprint",
#"%D 1994"],

HC := ["%A A.A. Hashim",
       "%A A.G. Constantinides",
       "%T Some new results on binary linear block codes",
       "%J Electronics Letters",
       "%V 10",
       "%P 31-33",
       "%D Feb. 1974"],

HP := ["%A A.A. Hashim",
       "%A V.S. Pozdniakov",
       "%T Computerized search for linear binary codes",
       "%J Electronics Letters",
       "%V 12",
       "%P 350-351",
       "%D July 1976"],

He := ["%A P.W. Heijnen",
       "%T Er bestaat geen binaire [33,9,13] code",
       "%R Afstudeerverslag, T.U. Delft",
       "%D Oct. 1993",
       "%X There is no binary [33,9,13] code"],

Q := ["%A H.J. Helgert",
       "%T Srivastava codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-18",
       "%P 292-297",
       "%D Mar. 1972"],

B := ["%A H.J. Helgert",
       "%A R.D. Stinaff",
       "%T Minimum-distance bounds for binary linear codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-19",
       "%P 344-356",
       "%D May 1973"],

A := ["%A H.J. Helgert",
       "%A R.D. Stinaff",
       "%T Minimum-distance bounds for binary linear codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-19",
       "%P 344-356",
       "%D May 1973"],

X := ["%A H.J. Helgert",
       "%A R.D. Stinaff",
       "%T Shortened BCH codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-19",
       "%P 818-820",
       "%D Nov. 1973"],

Hg := ["%A H.J. Helgert",
       "%T Alternant codes",
       "%J Inform. Contr.",
       "%V 26",
       "%P 369-380",
       "%D Dec. 1974"],

HY := ["%A T. Helleseth",
       "%A \*(/O. Ytrehus",
       "%T New bounds on binary linear codes of dimension 8",
       "%R Report in informatics No. 21, Dept. of informatics,",
       "Univ. of Bergen, Norway",
       "%D 1986",
       "%X No [122,8,60], [119,8,58], [95,8,46], [91,8,44], [83,8,40] exist",
       "(as quoted in {DHMY})."],

HvT := ["%A Tor Helleseth",
       "%A Henk C.A. van Tilborg",
       "%T The classification of all (145,7,72) binary linear codes",
       "%R TH-Report 80-WSK-01, Techn. Hogeschool Eindhoven",
       "%D April 1980"],

HvT2 := ["%A T. Helleseth",
       "%A H. van Tilborg",
       "%T A new class of codes meeting the Griesmer bound",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-27",
       "%P 548-555",
       "%D Sep. 1981"],

#["%A T. Helleseth",
#"%A \*(/O. Ytrehus",
#"%T New bounds on the minimum length of binary linear block codes of",
#"dimension 8",
#"%R Report No. 21, Dept. of Informatics, Univ. of Bergen, Norway,",
#"%D Sept. 1986."],

HY2 := ["%A T. Helleseth",
       "%A \*(/O. Ytrehus",
       "%T How to find a [33,8,14]-code",
       "%R Report in Informatics (preliminary version), Dept. of Informatics,",
       "Univ. of Bergen, Norway",
       "%D Nov. 1989"],

#["%A R. Hill",
#"%T Caps and Groups",
#"%B Coll. Intern. Teorie Combin. Acc. Naz. Lincei, Roma 1973",
#"%S Atti dei convegni Lincei",
#"%N 17",
#"%C Rome",
#"%D 1976",
#"%P 389-394"],

HT := ["%A Raymond Hill",
       "%A Karen L. Traynor",
       "%T The nonexistence of certain binary linear codes",
       "%J IEEE Trans. Inform. Theory",
       "%V 36",
       "%D Jul. 1990",
       "%P 917-922",
       "%X There are no [37,9,16], [54,10,24], [70,10,32], [86,10,40],",
       "[36,11,14], [33,12,12], [41,12,16], [49,12,20], [58,13,24],",
       "[82,13,36], [90,13,40], [67,14,28], [75,14,32], [43,21,12],",
       "[39,28,6] codes."],

Je := ["%A J.M. Jensen",
       "%T The concatenated structure of cyclic and Abelian codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-31",
       "%P 788-793",
       "%D Nov. 1985"],

Jo1 := ["%A S.M. Johnson",
       "%T A new upper bound for error-correcting codes",
       "%J IRE Trans. Inform. Theory",
       "%V IT-8",
       "%P 203-207",
       "%D April 1962"],

Jo2 := ["%A S.M. Johnson",
       "%T On upper bounds for unrestricted binary error-correcting codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-17",
       "%P 466-478",
       "%D July 1971"],

Pa := ["%A J. Justesen",
       "%A E. Paaske",
       "%A M. Ballan",
       "%J Quasi-cyclic unit memory codes",
       "%R Report, Institute of Circuit Theory and Telecommunication",
       "Techn. Univ. of Denmark, Lyngby",
       "%D July 1986"],

Z := ["%A M. Karlin",
       "%T [52,12,20] exists",
       "%R priv. comm. ([Helgert and Stinaff, Nov. 1973], ref. [30])"],

L := ["%A M. Karlin",
       "%T New binary coding results by circulants",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-15",
       "%P 81-92",
       "%D Jan. 1969"],

Ka := ["%A M. Kasahara",
       "%A Y. Sugiyama",
       "%A S. Hirasawa",
       "%A T. Namekawa",
       "%T A new class of binary codes constructed on the basis of BCH codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-21",
       "%P 582-585",
       "%D Sep. 1975"],

V := ["%A T. Kasami",
       "%A S. Lin",
       "%A W.W. Peterson",
       "%T Polynomial codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-14",
       "%P 807-814",
       "%D Nov. 1968"],

BCH := ["%A T. Kasami",
       "%A N. Tokura",
       "%T Some remarks on BCH bounds and minimum weights of binary primitive BCH codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-15",
       "%P 408-413",
       "%D May 1969"],

#["%A B.K. Kostova",
#"%A N.L. Manev",
#"%T A [25,8,10] code does not exist",
#"%J Comptes Rendus de l'Acad\*'emie bulgare des Sciences",
#"%V 43",
#"%P 41-44",
#"%D 1990"],

LC := ["%A M. Loeloeian",
       "%A J. Conan",
       "%T A $[55,16,19]$ binary Goppa code",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-30",
       "%P 773",
       "%D Sep. 1984"],

Lv := ["%A V.N. Logacev",
       "%T An improvement of the Griesmer bound in the case of",
       "small code distances",
       "%J Optimization Methods and Their Applications,",
       "(All-Union Summer Sem., Khakusy, Lake Baikal, 1972)",
       "(Russian), 182 Sibirsk. Energet. Inst., Sibirsk. Otdel. Akad. Nauk",
       "SSSR, Irkutsk",
       "%P 107-111",
       "%D 1974"],

A := ["%A F.J. MacWilliams",
       "%A N.J.A. Sloane",
       "%J The theory of error-correcting codes.",
       "%C Amsterdam",
       "%I North-Holland",
       "%D 1977"],

B := ["%A F.J. MacWilliams",
       "%A N.J.A. Sloane",
       "%J The theory of error-correcting codes.",
       "%C Amsterdam",
       "%I North-Holland",
       "%D 1977"],

C := ["%A F.J. MacWilliams",
       "%A N.J.A. Sloane",
       "%J The theory of error-correcting codes.",
       "%C Amsterdam",
       "%I North-Holland",
       "%D 1977"],

D := ["%A F.J. MacWilliams",
       "%A N.J.A. Sloane",
       "%J The theory of error-correcting codes.",
       "%C Amsterdam",
       "%I North-Holland",
       "%D 1977"],

E := ["%A F.J. MacWilliams",
       "%A N.J.A. Sloane",
       "%J The theory of error-correcting codes.",
       "%C Amsterdam",
       "%I North-Holland",
       "%D 1977"],

P1 := ["%A F.J. MacWilliams",
       "%A N.J.A. Sloane",
       "%J The theory of error-correcting codes.",
       "%C Amsterdam",
       "%I North-Holland",
       "%D 1977"],

P2 := ["%A F.J. MacWilliams",
       "%A N.J.A. Sloane",
       "%J The theory of error-correcting codes.",
       "%C Amsterdam",
       "%I North-Holland",
       "%D 1977"],

P3 := ["%A F.J. MacWilliams",
       "%A N.J.A. Sloane",
       "%J The theory of error-correcting codes.",
       "%C Amsterdam",
       "%I North-Holland",
       "%D 1977"],

P4 := ["%A F.J. MacWilliams",
       "%A N.J.A. Sloane",
       "%J The theory of error-correcting codes.",
       "%C Amsterdam",
       "%I North-Holland",
       "%D 1977"],

MS := ["%A F.J. MacWilliams",
       "%A N.J.A. Sloane",
       "%J The theory of error-correcting codes.",
       "%C Amsterdam",
       "%I North-Holland",
       "%D 1977"],

Y1 := ["%A F.J. MacWilliams",
       "%A N.J.A. Sloane",
       "%J The theory of error-correcting codes.",
       "%C Amsterdam",
       "%I North-Holland",
       "%D 1977"],

R := ["%A R.J. McEliece",
       "%A L.R. Welch",
       "%T Improvement on Johnson bound",
       "%R priv. comm. [\n(Hs], ref. [29]]"],

Mo := ["%A M. Morii",
       "%R email comm.",
       "%D Sept. 1993"],

MoY := ["%A M. Morii",
       "%A T. Yoshimura",
       "%R email comm.",
       "%D Nov 1993-Jan 1994"],

Pa := ["%A E. Paaske",
       "%T [48,12,17] and [52,13,18] exist",
       "%R priv. comm. (via Sloane)"],

I := ["%A W.W. Peterson",
       "%T Error-correcting codes.",
       "%C Cambridge, Mass.",
       "%I MIT Press",
       "%D 1961",
       "%P 166-167"],

Pi := ["%A P. Piret",
       "%T Good block codes derived from cyclic codes",
       "%J Electronics Letters",
       "%V 10",
       "%P 391-392",
       "%D Sep. 1974"],

Pi2 := ["%A P. Piret",
       "%T Good linear codes of lengths 27 and 28",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-26",
       "%P 227",
       "%D Mar. 1980"],

PT := ["%A G. Promhouse",
       "%A S. Tavares",
       "%T The minimum distance of all binary cyclic codes of",
       "odd lengths from 69 to 99",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-24",
       "%P 438-442",
       "%D July 1978"],

Pu := ["%A C.L.M. van Pul",
       "%J On bounds on codes",
       "%R Master's Thesis, Dept. of Math. and Comp. Sc., Eindhoven Univ. of Techn.,",
       "The Netherlands",
       "%D Aug. 1982"],

Pu2 := ["%A C.L.M. van Pul",
       "%T $[26,13,8]$ does not exist",
       "%R priv. comm.",
       "%D 1985"],

RR := ["%A V.V. Rao",
       "%A S.M. Reddy",
       "%T A $(48,31,8)$ linear code",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-19",
       "%P 709-711",
       "%D Sep. 1973"],

Ro := ["%A G. Roelofsen",
       "%J On Goppa and generalized Srivastava codes",
       "%R Master's Thesis, Dept. of Math. and Comp. Sc., Eindhoven Univ. of Techn.,",
       "The Netherlands",
       "%D Aug. 1982"],

Sa := ["%A Amir Said",
       "%R private comm. 910510 and 911121"],

SW := ["%A D. Schomaker",
       "%A M. Wirtz",
       "%T On binary cyclic codes of length from 101 to 127",
       "%J IEEE Trans. Inform. Theory",
       "%V 38",
       "%P 516-518",
       "%D March 1992"],

Sh := ["%A J.B. Shearer",
       "%R priv. comm.",
       "%D June 1988"],

Sh2 := ["%A J.B. Shearer",
       "%R priv. comm.",
       "%D Mar. 1992"],

Si := ["%A J. Simonis",
       "%T Binary even $[25,15,6]$ codes do not exist",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-33",
       "%P 151-153",
       "%D Jan. 1987"],

#["%A Juriaan Simonis",
#"%T A description of the $[16,7,6]$ codes",
#"%B AAECC",
#"%P 24-35",
#"%D 1991?",
#"%X Determines the (three) nonisomorphic $[16,7,6]$ codes",
#"(by hand; these had been found by computer search by Kostova & Manev)."],

SRC := ["%A N.J.A. Sloane",
       "%A S.M. Reddy",
       "%A C.L. Chen",
       "%T New binary codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-18",
       "%P 503-510",
       "%D July 1972"],

Y1 := ["%A N.J.A. Sloane",
       "%A S.M. Reddy",
       "%A C.L. Chen",
       "%T New binary codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-18",
       "%P 503-510",
       "%D July 1972"],

D := ["%A N.J.A. Sloane",
       "%A D.S. Whitehead",
       "%T New family of single-error correcting codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-16",
       "%P 717-719",
       "%D Nov. 1970"],

SS := ["%A G. Solomon",
       "%A J.J. Stiffler",
       "%T Algebraically punctured cyclic codes",
       "%J Inform. Contr.",
       "%V 8",
       "%P 170-179",
       "%D Apr. 1965"],

Su := ["%A Y. Sugiyama",
       "%A M. Kasahara",
       "%A S. Hirasawa",
       "%A T. Namekawa",
       "%T Some efficient binary codes constructed using Srivastava codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-21",
       "%P 581-582",
       "%D Sep. 1975",
       "%X Construct codes with $n = 2 sup m - t + (m+1)u$, $n - k = mt + u$,",
       "$d = 2t+1$ for $2 sup m > (m+1)t$ and $0 <= u <= t$."],

Su := ["%A Y. Sugiyama",
       "%A M. Kasahara",
       "%A S. Hirasawa",
       "%A T. Namekawa",
       "%T Further results on Goppa codes and their applications to",
       "constructing efficient binary codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-22",
       "%P 518-526",
       "%D Sep. 1976"],

vT1 := ["%A H.C.A. van Tilborg",
       "%T On quasi-cyclic codes with rate $1/m$",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-24",
       "%P 628-630",
       "%D Sep. 1978"],

vT2 := ["%A H.C.A. van Tilborg",
       "%T On the uniqueness resp. nonexistence of certain codes",
       "meeting the Griesmer bound",
       "%J Inform. Contr.",
       "%V 44",
       "%P 16-35",
       "%D Jan. 1980"],

vT3 := ["%A H.C.A. van Tilborg",
       "%T The smallest length of binary 7-dimensional linear codes",
       "with prescribed minimum distance",
       "%J Discr. Math.",
       "%V 33",
       "%P 197-207",
       "%D 1981"],

vT4 := ["%A H.C.A. van Tilborg",
       "%T A proof of the nonexistence of a binary (55,7,26) code",
       "%R TH-Report 79-WSK-09, Techn. Hogeschool Eindhoven",
       "%D Nov. 1979"],

To := ["%A L.M.G.M. Tolhuizen",
       "%J On the optimal use and the construction of linear block codes",
       "%R Master's Thesis, Dept. of Math. and Comp. Sc., Eindhoven Univ. of Techn.",
       "The Netherlands",
       "%D Nov. 1986",
       "%X There exist [120,50,24], [116,47,24], [112,44,24], [108,41,24],",
       "[104,38,24], [96,33,24], [61,10,26] codes. (These were also found by Cheng {Ch}.)",
       "Moreover, there exist [72,41,12], [74,43,11], [77,14,30], [78,13,32]",
       "and [99,35,24] codes. (These were also published in {To1}.)"],

To1 := ["%A L.M.G.M. Tolhuizen",
       "%T New binary linear block codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-33",
       "%D Sep. 1987",
       "%P 727-729",
       "%X There exist [72,41,12], [99,35,24], [78,13,32], [77,14,30],",
       "[74,43,11] codes. (See {To}.)"],

To2 := ["%A Ludo M.G.M. Tolhuizen",
       "%T Two new binary codes obtained by shortening a generalized concatenated code",
       "%J IEEE Trans. Inform. Theory",
       "%V 37",
       "%D Nov. 1991",
       "%P 1705",
       "%X There exist [75,13,30] and [75,11,32] codes."],

#["%A T. Verhoeff",
#"%J Updating a table of bounds on the minimum distance of",
#"binary linear codes",
#"%R EUT Report 85-WSK-01, ISSN 0167-9708, Coden: TEUEDE,",
#"Dept. of Math. and Comp. Sc., Eindhoven Univ. of Techn.,",
#"The Netherlands",
#"%D Jan. 1985"],

#["%A T. Verhoeff",
#"%T An updated table of minimum-distance bounds for binary linear codes",
#"%J IEEE Trans. Inform. Theory",
#"%V IT-33",
#"%P 665-680",
#"%D Sept. 1987"],

#["%A T. Verhoeff",
#"%T An updated table of minimum-distance bounds for binary linear codes",
#"%R preprint",
#"%D Jan. 1989"],

P := ["%A T.J. Wagner",
       "%T A search technique for quasi-perfect codes",
       "%J Inform. Contr.",
       "%V 9",
       "%P 94-99",
       "%D 1966"],

Wa := ["%A T.J. Wagner",
       "%T A remark concerning the minimum distance of binary group codes",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-11",
       "%P 458",
       "%D July 1965"],

We := ["%A L. Weng",
       "%T Concatenated codes with large minimum distance",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-23",
       "%P 613-615",
       "%D Sep. 1977"],

Wz := ["%A M. Wirtz, priv. comm.",
       "%D May 1988"],

Wz2 := ["%A M. Wirtz, comm. via B. Groneick",
       "%D July 1992"],

Wi := ["%A J.A. Wiseman",
       "%T A construction of nonlinear codes which betters or equals known results",
       "for certain parameters",
       "%J Inform. Contr.",
       "%V 48",
       "%P 70-79",
       "%D 1981"],

Wi := ["%A J.A. Wiseman",
       "%T New binary codes constructed by an old technique",
       "%J IEEE Trans. Inform. Theory",
       "%V IT-29",
       "%P 936-937",
       "%D Nov. 1983"],

Wi2 := ["%A J.A. Wiseman",
       "%T New binary codes from a generalization of Zinoviev's technique",
       "%J Information and Computation",
       "%V 98",
       "%D 1992",
       "%P 132-139"],

YH1 := ["%A \*(/Oyvind Ytrehus",
       "%A Tor Helleseth",
       "%T There is no binary [25,8,10] code",
       "%J IEEE Trans. Inform. Theory",
       "%V 36",
       "%P 695-696",
       "%D May 1990"],

Zv := ["%A V.A. Zinoviev",
       "%T Generalized cascade codes",
       "%J Problemy Peredachi Informatsii",
       "%V 12",
       "%P 5-15",
       "%O (English translation: pp. 2-9)",
       "%D Jan-Mar 1976"],

ZL := ["%A V.A. Zinoviev",
       "%A S.N. Litsyn",
       "%T Methods of code lengthening",
       "%J Problemy Peredachi Informatsii",
       "%V 18",
       "%P 29-42",
       "%O (English translation: pp. 244-254)",
       "%D Oct-Dec 1982"]

);