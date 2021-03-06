#############################################################################
##
#W  GAPDoc2LaTeX.gi                GAPDoc                        Frank Lübeck
##
##
#Y  Copyright (C)  2000,  Frank Lübeck,  Lehrstuhl D für Mathematik,  
#Y  RWTH Aachen
##
##  The  files GAPDoc2LaTeX.g{d,i}  contain a  conversion program  which
##  produces from a GAPDoc XML-document a version which can be processed
##  by LaTeX and pdfLaTeX.
##  

##  All  the work  is  done by  handler functions  for  each GAPDoc  XML
##  element.  These functions  are  bound as  components  to the  record
##  `GAPDoc2LaTeXProcs'. Most  element markup is easily  translated to a
##  corresponding LaTeX markup. It should  be easy to modify details for
##  some elements  by small local  changes of the  corresponding handler
##  function. The only slight complications  are in places where the XML
##  elements imply some labeling or  indexing. Also for all (sub)section
##  commands  we  add some  commands  which  cause  LaTeX to  produce  a
##  GAP  readable .pnr  file which  contains  the page  numbers for  all
##  subsections.
InstallValue(GAPDoc2LaTeXProcs, rec());

##  <#GAPDoc Label="GAPDoc2LaTeX">
##  <ManSection >
##  <Func Arg="tree" Name="GAPDoc2LaTeX" />
##  <Returns>&LaTeX; document as string</Returns>
##  <Func Name="SetGapDocLaTeXOptions" Arg="[...]" />
##  <Returns>Nothing</Returns>
##  <Description>
##  The   argument  <A>tree</A>   for   this  function   is  a   tree
##  describing  a   &GAPDoc;  XML   document  as  returned   by  <Ref
##  Func="ParseTreeXMLString"  /> (probably  also  checked with  <Ref
##  Func="CheckAndCleanGapDocTree"  />).  The   output  is  a  string
##  containing a  version of the document  which can be written  to a
##  file  and processed  with  &LaTeX; or  pdf&LaTeX;  (and  probably
##  &BibTeX; and <C>makeindex</C>). <P/>
##  
##  The   output   uses   the  <C>report</C>   document   class   and
##  needs    the   following    &LaTeX;   packages:    <C>a4wide</C>,
##  <C>amssymb</C>,  <C>inputenc</C>, <C>makeidx</C>,  <C>color</C>,
##  <C>fancyvrb</C>,  <C>psnfss</C>, <C>pslatex</C>, <C>enumitem</C>  
##  and  <C>hyperref</C>.   These
##  are  for  example  provided by  the  <Package>teTeX-1.0</Package>
##  or <Package>texlive</Package> 
##  distributions  of   &TeX;   (which    in   turn  are   used   for
##  most  &TeX;   packages  of  current  Linux   distributions);  see
##  <URL>http://www.tug.org/tetex/</URL>. <P/>
##  
##  In  particular, the  resulting  <C>pdf</C>-output (and 
##  <C>dvi</C>-output)  
##  contains  (internal and  external) hyperlinks  which can  be very
##  useful for online browsing of the document.<P/>
##  
##  The  &LaTeX;  processing  also  produces a  file  with  extension
##  <C>.pnr</C> which is &GAP; readable and contains the page numbers
##  for  all (sub)sections  of  the  document. This  can  be used  by
##  &GAP;'s online help; see <Ref Func="AddPageNumbersToSix" />.
##  
##  There is  support for  two types  of XML  processing instructions
##  which allow to change the options  used for the document class or
##  to add some extra lines to  the preamble of the &LaTeX; document.
##  They can be specified as in the following examples:
##  
##  <Listing Type="in top level of XML document">
##  <![CDATA[<?LaTeX Options="12pt"?>
##  <?LaTeX ExtraPreamble="\usepackage{blabla}
##  \newcommand{\bla}{blabla}
##  "?>
##  ]]></Listing>
##  
##  Non-ASCII characters in the &GAPDoc; document are translated to 
##  &LaTeX; input in ASCII-encoding with the help of <Ref Oper="Encode"/>
##  and the option <C>"LaTeX"</C>. See the documentation of 
##  <Ref Oper="Encode"/> for how to proceed if you have a character which 
##  is not handled (yet).<P/>
##  
##  A hint for  large documents: In many &TeX;  installations one can
##  easily reach some memory limitations with documents which contain
##  many (cross-)references. In <Package>teTeX</Package> you can look
##  for  a  file <F>texmf.cnf</F>  which  allows  to enlarge  certain
##  memory sizes.<P/>
##  
##  This  function works  by  running recursively  through the  document
##  tree   and   calling   a   handler  function   for   each   &GAPDoc;
##  XML   element.  Many   of  these   handler  functions   (usually  in
##  <C>GAPDoc2LaTeXProcs.&lt;ElementName&gt;</C>)  are not  difficult to
##  understand (the  greatest complications are some  commands for index
##  entries, labels  or the  output of page  number information).  So it
##  should be easy to adjust layout  details to your own taste by slight
##  modifications of the program. <P/>
##  
##  A    few     settings    can    be    adjusted     by   the   function
##  <Ref Func="SetGapDocLaTeXOptions"/>  which takes strings as
##  arguments. If the  arguments contain one of  the strings <C>"pdf"</C>,
##  <C>"dvi"</C>  or  <C>"ps"</C>  then &LaTeX;s  <C>hyperref</C>  package
##  is  configured  for optimized  output  of  the given  format  (default
##  is  <C>"pdf"</C>). If  <C>"color"</C>  or <C>"nocolor"</C>  is in  the
##  argument  list then  colors are  used or  not used,  respectively. The
##  default is  to use  colors but  <C>"nocolor"</C> can  be useful  for a
##  printable version of a manual (but  who wants to print such manuals?).
##  If "utf8" is an argument then the package <C>inputenc</C> is used with 
##  <C>UTF-8</C> encoding, instead of the default <C>latin1</C>.
##  If <C>"nopslatex"</C> is an argument then the package <C>psnfss</C>
##  is not used, otherwise it is. If the arguments contain
##  <C>"nobookmarks"</C> then navigation bookmarks for the pdf-viewer are
##  not generated, by default these are generated but not opened
##  in pdf-viewer.  If the arguments contain
##  <C>"customoptions="</C> this must be followed by a further argument
##  which is then inserted just before the <C>\begin{document}</C> in the
##  &LaTeX; file; this can be used to change options of the loaded packages,
##  to change colors and for many other purposes.
##  <P/>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##  


# the basic call, used recursivly with a result r from GetElement 
# and a string str to which the output should be appended
# arg: r       (then a string is returned)
# or:  r, str  (then the output is appended to string str)
InstallGlobalFunction(GAPDoc2LaTeX, function(arg)
  local  r,  str,  name;
  r := arg[1];
  if Length(arg)>1 then
    str := arg[2];
  else
    AddRootParseTree(r);
    str := "";
  fi;
  name := r.name;
  if not IsBound(GAPDoc2LaTeXProcs.(name)) then
    Info(InfoGAPDoc, 1, "#W WARNING: Don't know how to process element ", name, 
          " ---- ignored\n");
  else
    GAPDoc2LaTeXProcs.(r.name)(r, str);
  fi;
  if Length(arg)=1 then
    return str;
  fi;
end);

##  a common recursion loop
BindGlobal("GAPDoc2LaTeXContent", function(r, str)
  local   a;
  for a in r.content do
    GAPDoc2LaTeX(a, str);
  od;
end);

# width of index entries, we use a trick to split longer command names
GAPDoc2LaTeXProcs.MaxIndexEntryWidth := 35;

# a flag for recoding to LaTeX
GAPDoc2LaTeXProcs.recode := true;

# two utilities for attribute values like labels or text with special
# XML or LaTeX characters which gets printed (always as \texttt text)
GAPDoc2LaTeXProcs.EscapeAttrValOld := function(str)
  local res, c;
  res := "";
  for c in str do
    if c = '\\' then
##        Append(res, "{\\gdttbs}");
      Append(res, "\\texttt{\\symbol{92}}");
    elif c = '_' then
      Append(res, "\\_");
    elif c = '{' then
##        Append(res, "{\\gdttob}");
      Append(res, "\\texttt{\\symbol{123}}");
    elif c = '}' then
##        Append(res, "{\\gdttcb}");
      Append(res, "\\texttt{\\symbol{125}}");
    elif c = '^' then
##        Append(res, "{\\gdttht}");
      Append(res, "\\texttt{\\symbol{94}}");
    elif c = '~' then
##        Append(res, "{\\gdttti}");
      Append(res, "\\texttt{\\symbol{126}}");
    elif c = '<' then
      Append(res, "{\\textless}");
    elif c = '>' then
      Append(res, "{\\textgreater}");
    elif c = '&' then
      Append(res, "\\&");
    elif c = '%' then
      Append(res, "\\%");
    elif c = '$' then
      Append(res, "\\$");
    elif c = '#' then
      Append(res, "\\#");
    else
      Add(res, c);
    fi;
  od;
  return res;
end;
# now via Unicode, handle many more characters as well
GAPDoc2LaTeXProcs.EscapeAttrVal := function(str)
  return Encode(Unicode(str), GAPDoc2LaTeXProcs.Encoder);
end;

GAPDoc2LaTeXProcs.DeleteUsBs := function(str)
  return Filtered(str, x-> not (x in "\\_"));
end;

##  this is for getting a string "[ \"A\", 1, 1 ]" from [ "A", 1, 1 ]
GAPDoc2LaTeXProcs.StringNrs := function(ssnr)
  if IsInt(ssnr[1]) then
    return String(ssnr);
  else
    return Concatenation("[ \"", ssnr[1], "\", ", String(ssnr[2]), ", ",
                   String(ssnr[3]), " ]");
  fi;
end;

##  standard head of LaTeX file - part 1
GAPDoc2LaTeXProcs.Head1 := Concatenation([
"% generated by GAPDoc2LaTeX from XML source (Frank Luebeck, modified by Burkhard Höfling)\n",
"\\documentclass["]);

GAPDoc2LaTeXProcs.Head1xcolor := Concatenation([
"]{report}\n",
"\\usepackage{a4wide}\n",
"\\sloppy\n",
"\\pagestyle{myheadings}\n",
"\\usepackage{amssymb}\n",
"\\usepackage[INPUTENCENC]{inputenc}\n",
"\\usepackage{makeidx}\n",
"\\makeindex\n",
"\\DeclareFontShape{OT1}{cmtt}{bx}{n}\n",
"{<5><6><7><8>cmbtt8%\n",
"<9>cmbtt9%\n",
"<10><10.95>cmbtt10%\n",
"<12><14.4><17.28><20.74><24.88>cmbtt10%\n",
"}{}\n",
"\\usepackage{color}\n",
"\\definecolor{DarkOlive}{rgb}{0.1047,0.2412,0.0064}\n",
"\\definecolor{FireBrick}{rgb}{0.5812,0.0074,0.0083}\n",
"\\definecolor{RoyalBlue}{rgb}{0.0236,0.0894,0.6179}\n",
"\\definecolor{RoyalGreen}{rgb}{0.0236,0.6179,0.0894}\n",
"\\definecolor{RoyalRed}{rgb}{0.6179,0.0236,0.0894}\n",
"\\definecolor{LightBlue}{rgb}{0.8544,0.9511,1.0000}\n",
"\\definecolor{Black}{rgb}{0.0,0.0,0.0}\n",
"\\definecolor{FuncColor}{rgb}{0.0,0.0,0.0}\n",
"%% strange name because of pdflatex bug:\n",
"\\definecolor{Chapter }{rgb}{0.0,0.0,0.0}\n",
"\n",
"\\usepackage{fancyvrb}\n",
"\n",
"PSLATEXPKG\n",
"\n"]);
GAPDoc2LaTeXProcs.Head1xblack := Concatenation([
"]{report}\n",
"\\usepackage{a4wide}\n",
"\\sloppy\n",
"\\pagestyle{myheadings}\n",
"\\usepackage{amssymb}\n",
"\\usepackage[INPUTENCENC]{inputenc}\n",
"\\usepackage{makeidx}\n",
"\\makeindex\n",
"\\usepackage{color}\n",
"\\definecolor{DarkOlive}{rgb}{0.0,0.0,0.0}\n",
"\\definecolor{FireBrick}{rgb}{0.0,0.0,0.0}\n",
"\\definecolor{RoyalBlue}{rgb}{0.0,0.0,0.0}\n",
"\\definecolor{RoyalGreen}{rgb}{0.0,0.0,0.0}\n",
"\\definecolor{RoyalRed}{rgb}{0.0,0.0,0.0}\n",
"\\definecolor{LightBlue}{rgb}{0.0,0.0,0.0}\n",
"\\definecolor{Black}{rgb}{0.0,0.0,0.0}\n",
"\\definecolor{FuncColor}{rgb}{0.0,0.0,0.0}\n",
"%% strange name because of pdflatex bug:\n",
"\\definecolor{Chapter }{rgb}{0.0,0.0,0.0}\n",
"\n",
"\\usepackage{fancyvrb}\n",
"\n",
"PSLATEXPKG\n",
"\n"]);
##  default is with color, and latin1 encoding 
GAPDoc2LaTeXProcs.Head1x := GAPDoc2LaTeXProcs.Head1xcolor;

##  head - part 2 for dvi, ps and pdf output  (default is "pdf")
GAPDoc2LaTeXProcs.Head2dvi := "\\usepackage[\n";
GAPDoc2LaTeXProcs.Head2ps := "\\usepackage[dvips=true,\n";
GAPDoc2LaTeXProcs.Head2pdf := "\\usepackage[pdftex=true,\n";

##  head - part 3
GAPDoc2LaTeXProcs.Head3 := Concatenation([
"        a4paper=true,pdftitle={Written with GAPDoc},\n",
"        pdfcreator={LaTeX with hyperref package / GAPDoc},\n",
"        colorlinks=true,backref=page,breaklinks=true,linkcolor=RoyalBlue,\n",
"        citecolor=RoyalBlue,filecolor=Black,\n",
"        urlcolor=RoyalBlue,pdfpagemode={UseNone}]{hyperref}\n",
"\n",
"% write page numbers to a .pnr log file for online help\n",
"\\newwrite\\pagenrlog\n",
"\\immediate\\openout\\pagenrlog =\\jobname.pnr\n",
"\\immediate\\write\\pagenrlog{PAGENRS := [}\n",
"\\newcommand{\\logpage}[1]{\\protect\\write\\pagenrlog{#1, \\thepage,}}\n",
"%% were never documented, give conflicts with some additional packages\n",
"MATHBBABBREVS\n",
"\n",
"\\newcommand{\\GAP}{\\textsf{GAP}}\n",
"\n",
"%% nicer description environments, allows long labels\n",
"\\usepackage{enumitem}\n",
"\\setdescription{style=nextline}\n",
"CUSTOMOPTIONS\n",
"\n",
"\\begin{document}\n",
"\n"]);
                                   
GAPDoc2LaTeXProcs.Tail := Concatenation( 
"\\newpage\n",
"\\immediate\\write\\pagenrlog{[\"End\"], \\arabic{page}];}\n",
"\\immediate\\closeout\\pagenrlog\n",
"\\end{document}\n");
                                   
##  arg: a list of strings
##  for now only the output type (one of "dvi", "pdf" or "ps") is used
# to be enhanced
SetGapDocLaTeXOptions := function(arg)    
  local   gdp, pos;
  gdp := GAPDoc2LaTeXProcs;
  if "dvi" in arg then
    gdp.Head2 := gdp.Head2dvi;
  elif "ps" in arg then
    gdp.Head2 := gdp.Head2ps;
  else
    gdp.Head2 := gdp.Head2pdf;
  fi;
  if "nobookmarks" in arg then
    gdp.Head2 := Concatenation(gdp.Head2, ",bookmarks=false,");
  else
    gdp.Head2 := Concatenation(gdp.Head2, ",bookmarks=true,");
  fi;
  if "color" in arg then
    GAPDoc2LaTeXProcs.Head1x := GAPDoc2LaTeXProcs.Head1xcolor;
  elif "nocolor" in arg then
    GAPDoc2LaTeXProcs.Head1x := GAPDoc2LaTeXProcs.Head1xblack;
  fi;
  if "utf8" in arg then
    GAPDoc2LaTeXProcs.INPUTENCENC := "utf8";
    GAPDoc2LaTeXProcs.Encoder := "LaTeXUTF8";
  else
    GAPDoc2LaTeXProcs.INPUTENCENC := "latin1";
    GAPDoc2LaTeXProcs.Encoder := "LaTeX";
  fi;
  GAPDoc2LaTeXProcs.pslatex :=
              "\\usepackage{mathptmx,helvet}\n%\\usepackage{pslatex}";
  if "nopslatex" in arg then
    GAPDoc2LaTeXProcs.pslatex := Concatenation("%",GAPDoc2LaTeXProcs.pslatex, "\\usepackage{fix-cm} % needed for large cm font on title page\n");
  fi;
  if "usemathbbabbrevs" in arg then
    GAPDoc2LaTeXProcs.MATHBBABBREVS := Concatenation(
        "\\newcommand{\\Q}{\\mathbb{Q}}\n",
        "\\newcommand{\\R}{\\mathbb{R}}\n",
        "\\newcommand{\\C}{\\mathbb{C}}\n",
        "\\newcommand{\\Z}{\\mathbb{Z}}\n",
        "\\newcommand{\\N}{\\mathbb{N}}\n",
        "\\newcommand{\\F}{\\mathbb{F}}\n"
        );
  else
    GAPDoc2LaTeXProcs.MATHBBABBREVS := "";
  fi;
  pos := Position(arg,"customoptions=");
  if pos <> fail and Length(arg) > pos and IsString(arg[pos+1]) then
    GAPDoc2LaTeXProcs.CUSTOMOPTIONS := arg[pos+1];
  else
    GAPDoc2LaTeXProcs.CUSTOMOPTIONS := "";
  fi;
end;
# set defaults
SetGapDocLaTeXOptions();

GAPDoc2LaTeXProcs.firstsix := function(r, count)
  local a;
  a := PositionSet(r.root.sixcount, count{[1..3]});
  if a <> fail then
    a := r.root.six[r.root.sixindex[a]];
  fi;
  return a;
end;
##  write head and foot of LaTeX file.
GAPDoc2LaTeXProcs.WHOLEDOCUMENT := function(r, str)
  local   i,  pi,  t,  el,  a;
  
  ##  add internal paragraph numbering
  AddParagraphNumbersGapDocTree(r);
  
  ##  checking for processing instructions
  i := 1;
  pi := rec();
  while not r.content[i].name = "Book" do
    if r.content[i].name = "XMLPI" then
      t := r.content[i].content;
      if Length(t) > 5 and t{[1..6]} = "LaTeX " then
        el := GetSTag(Concatenation("<", t, ">"), 2);
        for a in NamesOfComponents(el.attributes) do
          pi.(a) := el.attributes.(a);
        od;
      fi;
    fi;
    i := i+1;
  od;
  ##  collect headings of labeled sections, here we must run through the
  ##  whole parse tree first to know the headings of text style forward
  ##  references
  GAPDoc2LaTeXProcs._labeledSections := rec();
  ApplyToNodesParseTree(r, function(rr) 
    if IsRecord(rr) and IsBound(rr.name)
       and rr.name in ["Chapter", "Section", "Subsection", "Appendix"] then
      # save heading for "Text" style references to section
      GAPDoc2LaTeXProcs.(rr.name)(rr,"");
    fi;
  end);

  ##  warn if no labels via .six available
  if not IsBound(r.six) then
    Info(InfoGAPDoc, 1, "#W WARNING: No labels for section number independent ",
      "anchors available.\n", 
      "#W Consider running the converter for the text version first!\n");
  fi;

  ##  now the actual work starts, we give the found processing instructions
  ##  to the Book handler
  GAPDoc2LaTeXProcs.Book(r.content[i], str, pi);
  Unbind(GAPDoc2LaTeXProcs._labeledSections);
end;

##  comments and processing instructions are generally ignored
GAPDoc2LaTeXProcs.XMLPI := function(r, str);
end;
GAPDoc2LaTeXProcs.XMLCOMMENT := function(r, str);
end;

# do nothing with Ignore
GAPDoc2LaTeXProcs.Ignore := function(arg)
end;

##  this makes head and foot of the LaTeX output
##  - the only processing instructions handled currently are
##    - options for the report class (german, papersize, ...) and 
##    - extra entries in the preamble (\usepackage, macro definitions, ...)
GAPDoc2LaTeXProcs.Book := function(r, str, pi)
  local   a;
  
  Append(str, GAPDoc2LaTeXProcs.Head1);
  if IsBound(pi.Options) then
    NormalizeWhitespace(pi.Options);
    Append(str, pi.Options);
  else
    Append(str, "a4paper,11pt");
  fi;
  a := SubstitutionSublist(GAPDoc2LaTeXProcs.Head1x, "INPUTENCENC", 
                           GAPDoc2LaTeXProcs.INPUTENCENC);
  a := SubstitutionSublist(a, "PSLATEXPKG", GAPDoc2LaTeXProcs.pslatex);
  
  Append(str, a);

  if IsBound(pi.ExtraPreamble) then
    Append(str, pi.ExtraPreamble);
  fi;
  Append(str, GAPDoc2LaTeXProcs.Head2);
  a := SubstitutionSublist(GAPDoc2LaTeXProcs.Head3, "MATHBBABBREVS",
                                  GAPDoc2LaTeXProcs.MATHBBABBREVS);
  a := SubstitutionSublist(a, "CUSTOMOPTIONS", GAPDoc2LaTeXProcs.CUSTOMOPTIONS);
  Append(str, a);
  
  # and now the text of the document
  GAPDoc2LaTeXContent(r, str);
  
  # that's it
  Append(str, GAPDoc2LaTeXProcs.Tail);
end;

##  the Body  just prints its content
GAPDoc2LaTeXProcs.Body := GAPDoc2LaTeXContent;



##  the title page,  the most complicated looking function
GAPDoc2LaTeXProcs.TitlePage := function(r, str)
  local   l,  ll, a,  s,  cont;
  
  # page number info for online help
  Append(str, Concatenation("\\logpage{", 
          GAPDoc2LaTeXProcs.StringNrs(r.count{[1..3]}), "}\n"));
  Append(str, "\\begin{titlepage}\n\\begin{center}\n");
  Append(str, "\\mbox{}\n\\vfill\n");
  
  # title
  l := Filtered(r.content, a-> a.name = "Title");
  Append(str, "{\\fontsize{48}{60}\\selectfont \\bfseries ");
  s := "";
  GAPDoc2LaTeXContent(l[1], s);
  Append(str, s);
  Append(str, "\\\\[1cm]}\n");
  # set title in info part of PDF document
  Append(str, "\\hypersetup{pdftitle=");
  Append(str, s);
  Append(str, "}\n");
  
  # the title is also used for the page headings
  Append(str, "\\markright{\\scriptsize \\mbox{}\\hfill ");
  Append(str, s);
  Append(str, " \\hfill\\mbox{}}\n");

  # subtitle
  l := Filtered(r.content, a-> a.name = "Subtitle");
  if Length(l)>0 then
    Append(str, "{\\Huge \\bfseries");
    GAPDoc2LaTeXContent(l[1], str);
    Append(str, "\\\\[1cm]}\n");
  fi;
  
  # version
  l := Filtered(r.content, a-> a.name = "Version");
  if Length(l)>0 then
    Append(str, "{\\huge ");
    GAPDoc2LaTeXContent(l[1], str);
    Append(str, "\\\\[1cm]}\n");
  fi;

  # date
  l := Filtered(r.content, a-> a.name = "Date");
  if Length(l)>0 then
    Append(str, "{");
    GAPDoc2LaTeXContent(l[1], str);
    Append(str, "\\mbox{}}\\\\[1cm]\n");
  fi;

  # author name(s)
  l := Filtered(r.content, a-> a.name = "Author");
  # collect author list for PDF info
  ll := [];
  for a in l do
    Append(str, "{\\Huge \\bfseries ");
    s := "";
    GAPDoc2LaTeXContent(rec(content := Filtered(a.content, b->
                   not b.name in ["Email", "Homepage", "Address"])), s);
    Append(str, s);
    Add(ll, s);
    Append(str, "\\\\}\n");
  od;
  Append(str, "\\hypersetup{pdfauthor=");
  Append(str, JoinStringsWithSeparator(ll, "; "));
  Append(str, "}\n");

  # extra comment for front page
  l := Filtered(r.content, a-> a.name = "TitleComment");
  if Length(l) > 0 then
    Append(str, "\\mbox{}\\\\[2cm]\n\\begin{minipage}{12cm}\\noindent\n");
    GAPDoc2LaTeXContent(l[1], str);
    Append(str, "\\end{minipage}\n\n");
  fi;
  Append(str, "\\vfill\n\n\n");
  
  # email, WWW-homepage and address of author(s), if given
  l := Filtered(r.content, a-> a.name = "Author");
  for a in l do
    cont := List(a.content, b-> b.name);
    if "Email" in cont or "Homepage" in cont or "Address" in cont then
      Append(str, "{\n\\large \\noindent \\bfseries ");
      GAPDoc2LaTeXContent(rec(content := Filtered(a.content, b->
                   not b.name in ["Email", "Homepage", "Address"])), str);
      Append(str, "\\\\\n");
      if "Email" in cont then
        Append(str, Concatenation(GAPDocTexts.d.Email, ": "));
        GAPDoc2LaTeX(a.content[Position(cont, "Email")], str);
      fi;
      if "Homepage" in cont then
        Append(str, "\\\\\n");
        Append(str, Concatenation(GAPDocTexts.d.Homepage, ": "));
        GAPDoc2LaTeX(a.content[Position(cont, "Homepage")], str);
      fi;
      if "Address" in cont then
        Append(str, "\\\\\n");
        Append(str, Concatenation(GAPDocTexts.d.Address, 
                                  ": \\begin{minipage}[t]{8cm}\\noindent\n"));
        GAPDoc2LaTeX(a.content[Position(cont, "Address")], str);
        Append(str, "\\end{minipage}\n");
      fi;
      Append(str, "\\\\\n}\n");
    fi;
  od;

  # Address outside the Author elements
  l := Filtered(r.content, a-> a.name = "Address");
  if Length(l)>0 then
    Append(str, "\n\\noindent ");
    Append(str, Concatenation("\\textbf{", GAPDocTexts.d.Address, 
                              ": }\\begin{minipage}[t]{8cm}\\noindent\n"));
    GAPDoc2LaTeXContent(l[1], str);
    Append(str, "\\end{minipage}\n");
  fi;
  
  Append(str, "\\end{center}\\end{titlepage}\n\n\\newpage");
  
  #  to make physical page numbers same as document page numbers
  Append(str, "\\setcounter{page}{2}\n");

  # abstract
  l := Filtered(r.content, a-> a.name = "Abstract");
  if Length(l)>0 then
    Append(str, Concatenation("{\\small \n\\section*{", GAPDocTexts.d.Abstract,
                              "}\n"));
    # page number info for online help
    Append(str, Concatenation("\\logpage{", 
            GAPDoc2LaTeXProcs.StringNrs(l[1].count{[1..3]}), "}\n"));
    GAPDoc2LaTeXContent(l[1], str);
    Append(str, "\\mbox{}}\\\\[1cm]\n");
  fi;
  
  # copyright page
  l := Filtered(r.content, a-> a.name = "Copyright");
  if Length(l)>0 then
    Append(str, Concatenation("{\\small \n\\section*{", GAPDocTexts.d.Copyright,
                              "}\n"));
    # page number info for online help
    Append(str, Concatenation("\\logpage{", 
            GAPDoc2LaTeXProcs.StringNrs(l[1].count{[1..3]}), "}\n"));
    GAPDoc2LaTeXContent(l[1], str);
    Append(str, "\\mbox{}}\\\\[1cm]\n");
  fi;

  # acknowledgement page
  l := Filtered(r.content, a-> a.name = "Acknowledgements");
  if Length(l)>0 then
    Append(str, Concatenation("{\\small \n\\section*{", 
                              GAPDocTexts.d.Acknowledgements, "}\n"));
    # page number info for online help
    Append(str, Concatenation("\\logpage{", 
            GAPDoc2LaTeXProcs.StringNrs(l[1].count{[1..3]}), "}\n"));
    GAPDoc2LaTeXContent(l[1], str);
    Append(str, "\\mbox{}}\\\\[1cm]\n");
  fi;

  # colophon page
  l := Filtered(r.content, a-> a.name = "Colophon");
  if Length(l)>0 then
    Append(str, Concatenation("{\\small \n\\section*{", GAPDocTexts.d.Colophon,
                              "}\n"));
    # page number info for online help
    Append(str, Concatenation("\\logpage{", 
            GAPDoc2LaTeXProcs.StringNrs(l[1].count{[1..3]}), "}\n"));
    GAPDoc2LaTeXContent(l[1], str);
    Append(str, "\\mbox{}}\\\\[1cm]\n");
  fi;  
  Append(str,"\\newpage\n\n");
end;

## this allows line breaks in URL strings s for use with \texttt{s} by
## inserting some "}\discretionary{}{}{}\texttt{" 
GAPDoc2LaTeXProcs.URLBreaks := function(s)
  local pos, ss, old;
  # not after ://
  pos := PositionSublist(s, "://");
  if pos = fail then
    pos := Minimum(3, Length(s));
  else
    pos := pos + 2;
  fi;
  ss := s{[1..pos]};
  old := pos;
  pos := Position(s, '/', old);
  while pos <> fail and pos+3 < Length(s) do
    Append(ss, s{[old+1..pos]});
    Append(ss, "}\\discretionary {}{}{}\\texttt{");
    old := pos;
    pos := Position(s, '/', old);
  od;
  Append(ss, s{[old+1..Length(s)]});
  return ss;
end;

##  ~ and # characters are correctly escaped
##  arg:  r, str[, pre]
GAPDoc2LaTeXProcs.Link := GAPDoc2LaTeXContent;
GAPDoc2LaTeXProcs.LinkText := GAPDoc2LaTeXContent;
GAPDoc2LaTeXProcs.URL := function(arg)
  local r, str, pre, rr, txt, s;
  r := arg[1];
  str := arg[2];
  if Length(arg)>2 then
    pre := arg[3];
  else
    pre := "";
  fi;
  rr := First(r.content, a-> a.name = "LinkText");
  if rr <> fail then
    txt := "";
    GAPDoc2LaTeXContent(rr, txt);
    rr := First(r.content, a-> a.name = "Link");
    if rr = fail then
      Info(InfoGAPDoc, 1, "#W missing <Link> element for text ", txt, "\n");
      s := "MISSINGLINK";
    else
      s := "";
      # must avoid recoding for first argument of \href
      GAPDoc2LaTeXProcs.recode := false;
      GAPDoc2LaTeXContent(rr, s);
      GAPDoc2LaTeXProcs.recode := true;
    fi;
  else
    s := "";
    GAPDoc2LaTeXProcs.recode := false;
    GAPDoc2LaTeXContent(r, s);
    GAPDoc2LaTeXProcs.recode := true;
    if IsBound(r.attributes.Text) then
      txt := r.attributes.Text;
    else
      # need recode in second argument of \href
      txt := Encode(Unicode(s, "UTF-8"), GAPDoc2LaTeXProcs.Encoder);
      txt := Concatenation("\\texttt{", txt, "}");
    fi;
  fi;
  Append(str, Concatenation("\\href{", pre, s, "} {", txt, "}"));
end;

GAPDoc2LaTeXProcs.Homepage := GAPDoc2LaTeXProcs.URL;

GAPDoc2LaTeXProcs.Email := function(r, str)
  # we add the `mailto://' phrase
  GAPDoc2LaTeXProcs.URL(r, str, "mailto://");
end;

##  the sectioning commands are just translated and labels are
##  generated, if given as attribute
GAPDoc2LaTeXProcs.ChapSect := function(r, str, sect)
  local   posh,  a,  s;
  posh := Position(List(r.content, a-> a.name), "Heading");
  # heading
  Append(str, Concatenation("\n\\", sect, "{"));
  s := "";
  if posh <> fail then      
    GAPDoc2LaTeXProcs.Heading1(r.content[posh], s);
  fi;
  Append(str, "\\textcolor{Chapter }{");
  Append(str, s);
  Append(str, "}}");
  # label for references
  if IsBound(r.attributes.Label) then
    Append(str, "\\label{");
    Append(str, r.attributes.Label);
    Append(str, "}\n");
    # save heading for "Text" style references to section
    GAPDoc2LaTeXProcs._labeledSections.(r.attributes.Label) := s;
  fi;
  # page number info for online help (no r.count below Ignore),
  # we also add a section number and page number independent label,
  # if available
  if IsBound(r.count) then
    Append(str, Concatenation("\\logpage{", 
            GAPDoc2LaTeXProcs.StringNrs(r.count{[1..3]}), "}\n"));
    if IsBound(r.root.six) then
##        a := First(r.root.six, x-> x[3] = r.count{[1..3]});
      a := GAPDoc2LaTeXProcs.firstsix(r, r.count);
      if a <> fail and IsBound(a[7]) then
        Append(str, Concatenation("\\hyperdef{L}{", a[7], "}{}\n"));
      fi;
    fi;
    # the actual content
    Append(str, "{\n");
    GAPDoc2LaTeXContent(r, str);
    Append(str, "}\n\n");
  fi;
end;

##  this really produces the content of the heading
GAPDoc2LaTeXProcs.Heading1 := function(r, str)
  GAPDoc2LaTeXContent(r, str);
end;
##  and this ignores the heading (for simpler recursion)
GAPDoc2LaTeXProcs.Heading := function(r, str)
end;

GAPDoc2LaTeXProcs.Chapter := function(r, str)
  GAPDoc2LaTeXProcs.ChapSect(r, str, "chapter");
end;

GAPDoc2LaTeXProcs.Appendix := function(r, str)
  if r.count[1] = "A" then
    Append(str, "\n\n\\appendix\n\n");
  fi;
  GAPDoc2LaTeXProcs.ChapSect(r, str, "chapter");
end;

GAPDoc2LaTeXProcs.Section := function(r, str)
  GAPDoc2LaTeXProcs.ChapSect(r, str, "section");
end;

GAPDoc2LaTeXProcs.Subsection := function(r, str)
  GAPDoc2LaTeXProcs.ChapSect(r, str, "subsection");
end;

##  table of contents, the job is completely delegated to LaTeX
GAPDoc2LaTeXProcs.TableOfContents := function(r, str)
  # page number info for online help
  Append(str, Concatenation("\\def\\contentsname{", GAPDocTexts.d.Contents, 
          "\\logpage{", GAPDoc2LaTeXProcs.StringNrs(r.count{[1..3]}), "}}\n"));
  Append(str, "\\definecolor{Chapter }{rgb}{0.0236,0.0894,0.6179}\n");
  Append(str, "\\setcounter{tocdepth}{1}\n");
  Append(str, "\n\\tableofcontents\n");
  Append(str, "\\definecolor{Chapter }{rgb}{0.0,0.0,0.0}\n");
  Append(str, "\\newpage\n\n");
end;

##  bibliography, the job is completely delegated to LaTeX and BibTeX
GAPDoc2LaTeXProcs.Bibliography := function(r, str)
  local dat, fname, t, b, st, a;
  # check if bib data are in BibXMLext format, in that case produce a 
  # BibTeX file
  dat := r.attributes.Databases;
  dat := SplitString(dat, "", ", \n\t\b");
  dat := Filtered(dat, a-> Length(a) > 3 and 
                                     a{[Length(a)-3..Length(a)]} = ".xml");
  dat := List(dat, a-> Filename(r.root.bibpath, a));
  for fname in dat do
    b := ParseBibXMLextFiles(fname);
    b := List(b.entries, a-> RecBibXMLEntry(a, b.strings, "BibTeX"));
    WriteBibFile(Concatenation(fname, ".bib"), [b, [], []]);
  od;
  if IsBound(r.attributes.Style) then
    st := r.attributes.Style;
  else
    st := "alpha";
  fi;

  # page number info for online help
  Append(str, Concatenation("\\def\\bibname{", GAPDocTexts.d.References,
          "\\logpage{", 
          GAPDoc2LaTeXProcs.StringNrs(r.count{[1..3]}), "}\n"));
  if IsBound(r.root.six) then
##      a := First(r.root.six, x-> x[3] = r.count{[1..3]});
    a := GAPDoc2LaTeXProcs.firstsix(r, r.count);
    if a <> fail and IsBound(a[7]) then
      Append(str, Concatenation("\\hyperdef{L}{", a[7], "}{}\n"));
    fi;
  fi;
  Append(str, "}\n");
  Append(str, "\\clearpage\n\\phantomsection % Ensures that a PDF bookmark is set here\n");
  Append(str, Concatenation ("\\addcontentsline{toc}{chapter}{", GAPDocTexts.d.References, "}\n"));
  Append(str, "\n\\bibliographystyle{");
  Append(str, st);
  Append(str,"}\n\\bibliography{");
  Append(str, r.attributes.Databases);
  Append(str, "}\n\n");
end;

##  as default we normalize white space in text and split the result 
##  into lines (leading and trailing white space is also substituted 
##  by one space).
GAPDoc2LaTeXProcs.PCDATA := function(r, str)
  local   lines,  i;
  if Length(r.content)>0 and r.content[1] in WHITESPACE then
    Add(str, ' ');
  fi;
  lines := r.content;
  if GAPDoc2LaTeXProcs.recode = true then
    lines := Encode(Unicode(lines), GAPDoc2LaTeXProcs.Encoder);
  fi;
  lines := FormatParagraph(lines, "left");
  if Length(lines)>0 then
    if r.content[Length(r.content)] in WHITESPACE then
      lines[Length(lines)] := ' ';
    else
      Unbind(lines[Length(lines)]);
    fi;
  fi;
  Append(str, lines);
end;

##  end of paragraph 
GAPDoc2LaTeXProcs.P := function(r, str)
  Append(str, "\n\n");
end;

##  forced line break
GAPDoc2LaTeXProcs.Br := function(r, str)
  Append(str, "\\\\\n");
end;

##  generic function to get content and wrap by some markup
GAPDoc2LaTeXProcs.WrapMarkup := function(r, str, pre, post)
  local s;
  s := "";
  GAPDoc2LaTeXContent(r, s);
  Append(str, Concatenation(pre, s, post));
end;

##  setting in typewriter
GAPDoc2LaTeXProcs.WrapTT := function(r, str)
  GAPDoc2LaTeXProcs.WrapMarkup(r, str, "\\texttt{", "}");
end;

##  setting in typewriter
GAPDoc2LaTeXProcs.WrapBTT := function(r, str)
  GAPDoc2LaTeXProcs.WrapMarkup(r, str, "\\texttt{\\textbf{", "}}");
end;

##  GAP keywords 
GAPDoc2LaTeXProcs.K := function(r, str)
  GAPDoc2LaTeXProcs.WrapTT(r, str);
end;

##  verbatim GAP code
GAPDoc2LaTeXProcs.C := function(r, str)
  GAPDoc2LaTeXProcs.WrapTT(r, str);
end;

##  file names
GAPDoc2LaTeXProcs.F := function(r, str)
  GAPDoc2LaTeXProcs.WrapTT(r, str);
end;

##  argument names
GAPDoc2LaTeXProcs.A := function(r, str)
  Append(str, "\\mbox{");
##    GAPDoc2LaTeXProcs.WrapTT(r, str);
  GAPDoc2LaTeXProcs.WrapMarkup(r, str, "{\\rmfamily\\itshape ", "}");
  Append(str, "}");
end;

##  simple maths
GAPDoc2LaTeXProcs.M := function(r, str)
  local saveenc;
  Append(str, "$");
  # here the input is already coded in LaTeX
  saveenc := GAPDoc2LaTeXProcs.Encoder;
  GAPDoc2LaTeXProcs.Encoder := "LaTeXleavemarkup";
  GAPDoc2LaTeXContent(r, str);
  GAPDoc2LaTeXProcs.Encoder := saveenc;
  Append(str, "$");
end;

##  in LaTeX same as <M>
GAPDoc2LaTeXProcs.Math := GAPDoc2LaTeXProcs.M;

##  displayed maths
GAPDoc2LaTeXProcs.Display := function(r, str)
  local saveenc;
  if Length(str)>0 and str[Length(str)] <> '\n' then
    Add(str, '\n');
  fi;
  Append(str, "\\[");
  saveenc := GAPDoc2LaTeXProcs.Encoder;
  GAPDoc2LaTeXProcs.Encoder := "LaTeXleavemarkup";
  GAPDoc2LaTeXContent(r, str);
  GAPDoc2LaTeXProcs.Encoder := saveenc;
  Append(str, "\\]\n");
end;

##  emphazised text
GAPDoc2LaTeXProcs.Emph := function(r, str)
  local   a;
  Append(str, "\\emph{");
  GAPDoc2LaTeXContent(r, str);
  Append(str, "}");
end;

##  quoted text
GAPDoc2LaTeXProcs.Q := function(r, str)
  local   a;
  Append(str, "``");
  GAPDoc2LaTeXContent(r, str);
  Append(str, "''");
end;

##  Package names
GAPDoc2LaTeXProcs.Package := function(r, str)
  local   a;
  Append(str, "\\textsf{");
  GAPDoc2LaTeXContent(r, str);
  Append(str, "}");
end;

##  menu items
GAPDoc2LaTeXProcs.B := function(r, str)
  local   a;
  Append(str, "\\textsc{");
  GAPDoc2LaTeXContent(r, str);
  Append(str, "}");
end;

GAPDoc2LaTeXProcs.verbcontent := function(r, delfirst)
  local cont;
  # here we cannot use recoding, fall back to SimplifiedUnicodeString (latin1)
  # first collect content without recoding or reformatting
  cont := GetTextXMLTree(r);
  if GAPDoc2LaTeXProcs.INPUTENCENC = "latin1" then
    cont := Encode(SimplifiedUnicodeString(Unicode(cont), "latin1"), "latin1");
  fi;
  cont := SplitString(cont, "\n", "");
  # if first line has white space only, we remove it
  if delfirst and Length(cont) > 0 and ForAll(cont[1], x-> x in WHITESPACE) then
    cont := cont{[2..Length(cont)]};
  fi;
  cont := Concatenation(List(cont, a-> Concatenation("  ", a, "\n")));
  return cont;
end;

##  verbatim GAP session
GAPDoc2LaTeXProcs.Verb := function(r, str)
  local   cont,  a,  s;
  Append(str, "\n\\begin{verbatim}");
  Append(str, GAPDoc2LaTeXProcs.verbcontent(r, false));
  Append(str, "\\end{verbatim}\n");
end;

GAPDoc2LaTeXProcs.ExampleLike := function(r, str, label)
  local   cont,  a,  s;
  Append(str, Concatenation("\n\\begin{Verbatim}[fontsize=\\small,",
          "frame=single"));
  if label <> "" then
    Append (str,Concatenation(",label=", label));
  fi;
  Append (str, "]\n");
  Append(str, GAPDoc2LaTeXProcs.verbcontent(r, true));  
  Append(str, "\\end{Verbatim}\n");
end;

##  log of session and GAP code is typeset the same way as <Example>
GAPDoc2LaTeXProcs.Example := function(r, str)
  GAPDoc2LaTeXProcs.ExampleLike(r, str, GAPDocTexts.d.Example);
end;
GAPDoc2LaTeXProcs.Log := function(r, str)
  GAPDoc2LaTeXProcs.ExampleLike(r, str, GAPDocTexts.d.Log);
end;
GAPDoc2LaTeXProcs.Listing := function(r, str)
  if IsBound(r.attributes.Type) then
    GAPDoc2LaTeXProcs.ExampleLike(r, str, r.attributes.Type);
  else
    GAPDoc2LaTeXProcs.ExampleLike(r, str, "");
  fi;
end;

##  explicit labels
GAPDoc2LaTeXProcs.Label := function(r, str)
  Append(str, "\\label{");
  Append(str, r.attributes.Name);
  Append(str, "}");
end;

##  citations
GAPDoc2LaTeXProcs.Cite := function(r, str)
  Append(str, "\\cite");
  if IsBound(r.attributes.Where) then
    Add(str, '[');
    Append(str, Encode(Unicode(r.attributes.Where), GAPDoc2LaTeXProcs.Encoder));
    Add(str, ']');
  fi;
  Add(str, '{');
  Append(str, r.attributes.Key);
  Add(str, '}');
end;

##  explicit index entries
GAPDoc2LaTeXProcs.Subkey := GAPDoc2LaTeXContent;
GAPDoc2LaTeXProcs.Index := function(r, str)
  local s, sub, a;
  s := "";
  sub := "";
  for a in r.content do
    if a.name = "Subkey" then
      GAPDoc2LaTeX(a, sub);
    else
      GAPDoc2LaTeX(a, s);
    fi;
  od;
  NormalizeWhitespace(s);
  NormalizeWhitespace(sub);
  if IsBound(r.attributes.Key) then
    s := Concatenation(r.attributes.Key, "@", s);
  fi;
  if Length(sub) > 0 then
    s := Concatenation(s, "!", sub);
  elif IsBound(r.attributes.Subkey) then
    s := Concatenation(s, "!", r.attributes.Subkey);
  fi;
  Append(str, "\\index{");
  Append(str, s);
  Append(str, "}");
end;

##  this produces an implicit index entry and a label entry
GAPDoc2LaTeXProcs.LikeFunc := function(r, str, typ)
  local nam, namclean, lab, inam, i;
  Append(str, "\\noindent\\textcolor{FuncColor}{$\\Diamond$\\ \\texttt{");
  nam := r.attributes.Name;
  namclean := GAPDoc2LaTeXProcs.DeleteUsBs(nam);
  # we allow _,  \ and so on here
  nam := GAPDoc2LaTeXProcs.EscapeAttrVal(nam);
  Append(str, nam);
  Append (str, "}}");
  if IsBound(r.attributes.Arg) then
    Append(str, "({\\rmfamily\\itshape ");
    Append(str, GAPDoc2LaTeXProcs.EscapeAttrVal(
                NormalizedArgList(r.attributes.Arg)));
    Append(str, "})");
  fi;
  # possible label
  if IsBound(r.attributes.Label) then
    lab := Concatenation("!", r.attributes.Label);
  else
    lab := "";
  fi;
  # index entry
  # handle extremely long names
  if Length(nam) > GAPDoc2LaTeXProcs.MaxIndexEntryWidth then
    inam := nam{[1..3]};
    for i in [4..Length(nam)-3] do
      if nam[i] in CAPITALLETTERS then
        Append(inam, "}\\-\\texttt{");
      fi;
      Add(inam, nam[i]);
    od;
    Add(inam, nam[Length(nam)-2]); Add(inam, nam[Length(nam)-1]);
    Add(inam, nam[Length(nam)]);
  else
    inam := nam;
  fi;
  Append(str, Concatenation("\\index{", namclean, "@\\texttt{",
          inam, "}", lab, "}\n"));
  # label (if not given, the default is the Name)
  if IsBound(r.attributes.Label) then
    namclean := Concatenation(namclean, ":", r.attributes.Label);
  fi;
  Add(GAPDoc2LaTeXProcs._currentSubsection, namclean);
  Append(str, Concatenation("\\label{", namclean, "}\n"));
  # some hint about the type of the variable
  Append(str, "\\hfill{\\scriptsize (");
  Append(str, typ);
  Append(str, ")}\\\\\n");
end;

GAPDoc2LaTeXProcs.Func := function(r, str)
  GAPDoc2LaTeXProcs.LikeFunc(r, str, GAPDocTexts.d.Func);
end;

GAPDoc2LaTeXProcs.Oper := function(r, str)
  GAPDoc2LaTeXProcs.LikeFunc(r, str, GAPDocTexts.d.Oper);
end;

GAPDoc2LaTeXProcs.Meth := function(r, str)
  GAPDoc2LaTeXProcs.LikeFunc(r, str, GAPDocTexts.d.Meth);
end;

GAPDoc2LaTeXProcs.Filt := function(r, str)
  # r.attributes.Type could be "representation", "category", ...
  if IsBound(r.attributes.Type) then
    GAPDoc2LaTeXProcs.LikeFunc(r, str, r.attributes.Type);
  else
    GAPDoc2LaTeXProcs.LikeFunc(r, str, GAPDocTexts.d.Filt);
  fi;
end;

GAPDoc2LaTeXProcs.Prop := function(r, str)
  GAPDoc2LaTeXProcs.LikeFunc(r, str, GAPDocTexts.d.Prop);
end;

GAPDoc2LaTeXProcs.Attr := function(r, str)
  GAPDoc2LaTeXProcs.LikeFunc(r, str, GAPDocTexts.d.Attr);
end;

GAPDoc2LaTeXProcs.Var := function(r, str)
  GAPDoc2LaTeXProcs.LikeFunc(r, str, GAPDocTexts.d.Var);
end;

GAPDoc2LaTeXProcs.Fam := function(r, str)
  GAPDoc2LaTeXProcs.LikeFunc(r, str, GAPDocTexts.d.Fam);
end;

GAPDoc2LaTeXProcs.InfoClass := function(r, str)
  GAPDoc2LaTeXProcs.LikeFunc(r, str, GAPDocTexts.d.InfoClass);
end;

##  using the HelpData(.., .., "ref") interface
GAPDoc2LaTeXProcs.ResolveExternalRef := function(bookname,  label, nr)
  local info, match, res;
  info := HELP_BOOK_INFO(bookname);
  if info = fail then
    return fail;
  fi;
  match := Concatenation(HELP_GET_MATCHES(info, SIMPLE_STRING(label), true));
  if Length(match) < nr then
    return fail;
  fi;
  res := HELP_BOOK_HANDLER.(info.handler).HelpData(info, match[nr][2], "ref");
  res[1] := SubstitutionSublist(res[1], " (not loaded): ", ": ", "one");
  return res;
end;

GAPDoc2LaTeXProcs.Ref := function(r, str)
  local   funclike,  int,  txt,  ref,  lab,  sectlike, slab;
  
  # function like cases
  funclike := [ "Func", "Oper", "Meth", "Filt", "Prop", "Attr", "Var", 
                "Fam", "InfoClass" ];
  int := Intersection(funclike, NamesOfComponents(r.attributes));
  if Length(int)>0 then
    txt := r.attributes.(int[1]);
    if IsBound(r.attributes.Label) then
      lab := Concatenation(txt, ":", r.attributes.Label);
    else
      lab := txt;
    fi;
    if IsBound(r.attributes.BookName) then
      slab := txt;
      if IsBound(r.attributes.Label) then
        slab := Concatenation(slab, " (", r.attributes.Label, ")");
      fi;
      ref := GAPDoc2LaTeXProcs.ResolveExternalRef(
                                             r.attributes.BookName, slab, 1);
      if ref = fail then
        Info(InfoGAPDoc, 1, "#W WARNING: non resolved reference: ",
                            r.attributes, "\n");
        ref := Concatenation(" (", Encode(Unicode(lab),
               GAPDoc2LaTeXProcs.Encoder)
               , "???)");
      else
        # the search text for online help including book name
        ref := Concatenation(" (", 
                              GAPDoc2LaTeXProcs.EscapeAttrVal(ref[1]), ")");
      fi;
    else
      ref := Concatenation(" (\\ref{", GAPDoc2LaTeXProcs.DeleteUsBs(lab), "})");
    fi;
    # delete ref, if pointing to current subsection
    if IsBound(GAPDoc2LaTeXProcs._currentSubsection) and 
                 lab in GAPDoc2LaTeXProcs._currentSubsection then
      ref := "";
    fi;
    Append(str, Concatenation("\\texttt{", GAPDoc2LaTeXProcs.EscapeAttrVal(txt), 
            "}", ref));
    return;
  fi;
  
  # section like cases
  sectlike := ["Chap", "Sect", "Subsect", "Appendix"];
  int := Intersection(sectlike, NamesOfComponents(r.attributes));
  if Length(int)>0 then
    txt := r.attributes.(int[1]);
    if IsBound(r.attributes.Label) then
      lab := r.attributes.Label;
    else
      lab := txt;
    fi;
    if IsBound(r.attributes.BookName) then
      ref := GAPDoc2LaTeXProcs.ResolveExternalRef(
                                          r.attributes.BookName, lab, 1);
      if ref = fail then
        Info(InfoGAPDoc, 1, "#W WARNING: non resolved reference: ",
                            r.attributes, "\n");
        ref := Concatenation(" (", lab, "???)");
      else
        # the search text for online help including book name
        ref := Concatenation(" (\\textbf{", GAPDoc2LaTeXProcs.EscapeAttrVal(ref[1]), "})");
      fi;
    elif IsBound(r.attributes.Style) and r.attributes.Style = "Text" then
      if IsBound(GAPDoc2LaTeXProcs._labeledSections.(lab)) then
        ref := Concatenation("`", StripBeginEnd(
                GAPDoc2LaTeXProcs._labeledSections.(lab), WHITESPACE), "'"); 
      else
        Info(InfoGAPDoc, 1, "#W WARNING: non resolved reference: ",
                            r.attributes, "\n");
        ref := "`???'";
      fi;
    else
      # with sectioning references Label must be given
      lab := r.attributes.(int[1]);
      #ref := Concatenation("\\ref{", GAPDoc2LaTeXProcs.EscapeAttrVal(lab), "}");
      ref := Concatenation("\\ref{", lab, "}");
    fi;
    Append(str, ref);
    return;
  fi;
  
  # neutral reference to a label
  if IsBound(r.attributes.BookName) then
    if IsBound(r.attributes.Label) then
      lab := r.attributes.Label;
    else
      lab := "_X_X_X";
    fi;
    ref := GAPDoc2LaTeXProcs.ResolveExternalRef(
                                        r.attributes.BookName, lab, 1);
    if ref = fail then
      Info(InfoGAPDoc, 1, "#W WARNING: non resolved reference: ",
                            r.attributes, "\n");
      ref := Concatenation(" ", GAPDoc2LaTeXProcs.EscapeAttrVal(lab), "??? ");
    else
      # the search text for online help including book name
      ref := Concatenation(" \\textbf{", GAPDoc2LaTeXProcs.EscapeAttrVal(ref[1]), "}");
    fi;
  else
    lab := r.attributes.Label;
    ref := Concatenation("\\ref{", GAPDoc2LaTeXProcs.EscapeAttrVal(lab), "}");
  fi;
  Append(str, ref);
  return;
end;

# just process
GAPDoc2LaTeXProcs.Address := function(r, str)
  GAPDoc2LaTeXContent(r, str);
end;

GAPDoc2LaTeXProcs.Description := function(r, str)
  Append(str, "\n\n");
  GAPDoc2LaTeXContent(r, str);
end;

GAPDoc2LaTeXProcs.Returns := function(r, str)
  Append(str, Concatenation("\\textbf{\\indent ", GAPDocTexts.d.Returns, 
                            ":\\ }\n"));
  GAPDoc2LaTeXContent(r, str); 
  Append(str,"\n\n");
end;

GAPDoc2LaTeXProcs.ManSection := function(r, str)
  local   funclike,  f,  lab,  i, a;
  
  # if there is a Heading then handle as subsection
  if ForAny(r.content, a-> IsRecord(a) and a.name = "Heading") then
    GAPDoc2LaTeXProcs._currentSubsection := r.count{[1..3]};
    GAPDoc2LaTeXProcs.ChapSect(r, str, "subsection");
    Unbind(GAPDoc2LaTeXProcs._currentSubsection);
    return;
  fi;
  # function like elements
  funclike := [ "Func", "Oper", "Meth", "Filt", "Prop", "Attr", "Var", 
                "Fam", "InfoClass" ];
  
  # heading comes from name of first function like element
  i := 1;
  while not r.content[i].name in funclike do
    i := i+1;
  od;
  f := r.content[i];
  if IsBound(f.attributes.Label) then
    lab := Concatenation(" (", f.attributes.Label, ")");
  else
    lab := "";
  fi;
  Append(str, Concatenation("\n\n\\subsection{\\textcolor{Chapter }{", 
          GAPDoc2LaTeXProcs.EscapeAttrVal(f.attributes.Name), lab, "}}\n"));
  # page number info for online help
  Append(str, Concatenation("\\logpage{", 
          GAPDoc2LaTeXProcs.StringNrs(r.count{[1..3]}), "}\\nobreak\n"));
  if IsBound(r.root.six) then
##      a := First(r.root.six, x-> x[3] = r.count{[1..3]});
    a := GAPDoc2LaTeXProcs.firstsix(r, r.count);
    if a <> fail and IsBound(a[7]) then
      Append(str, Concatenation("\\hyperdef{L}{", a[7], "}{}\n"));
    fi;
  fi;
  # to avoid references to local subsection in description:
  GAPDoc2LaTeXProcs._currentSubsection := r.count{[1..3]};
  Append(str, "{");
  GAPDoc2LaTeXContent(r, str);
  Append(str, "}\n\n");
  Unbind(GAPDoc2LaTeXProcs._currentSubsection);
end;

GAPDoc2LaTeXProcs.Mark := function(r, str)
  Append(str, "\n\\item[{");
  GAPDoc2LaTeXContent(r, str);
  Append(str, "}] ");
end;

GAPDoc2LaTeXProcs.Item := function(r, str)
  Append(str, "\n\\item ");
  GAPDoc2LaTeXContent(r, str);
end;

GAPDoc2LaTeXProcs.List := function(r, str)
  local   item,  type,  a;
  if "Mark" in List(r.content, a-> a.name) then
    item := "";
    type := "description";
  else
    item := "\n\\item ";
    type := "itemize";
  fi;
  Append(str, Concatenation("\n\\begin{", type, "}"));
  for a in r.content do
    if a.name = "Mark" then
      GAPDoc2LaTeXProcs.Mark(a, str);
    elif a.name = "Item" then
      Append(str, item);
      GAPDoc2LaTeXContent(a, str);
    fi;
  od;
  Append(str, Concatenation("\n\\end{", type, "}\n"));
end;

GAPDoc2LaTeXProcs.Enum := function(r, str)
  Append(str, "\n\\begin{enumerate}");
  GAPDoc2LaTeXContent(r, str);
  Append(str, "\n\\end{enumerate}\n");
end;

GAPDoc2LaTeXProcs.TheIndex := function(r, str)
  local a;
  # page number info for online help
  Append(str, Concatenation("\\def\\indexname{", GAPDocTexts.d.Index, 
            "\\logpage{", GAPDoc2LaTeXProcs.StringNrs(r.count{[1..3]}), "}\n"));
  if IsBound(r.root.six) then
##      a := First(r.root.six, x-> x[3] = r.count{[1..3]});
    a := GAPDoc2LaTeXProcs.firstsix(r, r.count);
    if a <> fail and IsBound(a[7]) then
      Append(str, Concatenation("\\hyperdef{L}{", a[7], "}{}\n"));
    fi;
  fi;
  Append(str, "}\n");
  Append(str, "\\clearpage\n\\phantomsection % Ensures that a PDF bookmark is set here\n");
  Append(str, Concatenation ("\\addcontentsline{toc}{chapter}{", GAPDocTexts.d.Index, "}\n"));
  Append(str, "\n\n\\printindex\n\n");
end;

# like PCDATA
GAPDoc2LaTeXProcs.EntityValue := GAPDoc2LaTeXProcs.PCDATA;

GAPDoc2LaTeXProcs.Table := function(r, str)
  local cap;
  if (IsBound(r.attributes.Only) and r.attributes.Only <> "LaTeX") or
     (IsBound(r.attributes.Not) and r.attributes.Not = "LaTeX") then
    return;
  fi;
  # head part of table and tabular
  if IsBound(r.attributes.Label) then
    Append(str, "\\mbox{}\\label{");
    Append(str, r.attributes.Label);
    Add(str, '}');
  fi;
  Append(str, "\\begin{center}\n\\begin{tabular}{");
  Append(str, r.attributes.Align);
  Add(str, '}');
  # the rows of the table
  GAPDoc2LaTeXContent(r, str);
  # the trailing part with caption, if given
  Append(str, "\\end{tabular}\\\\[2mm]\n");
  cap := Filtered(r.content, a-> a.name = "Caption");
  if Length(cap) > 0 then
    GAPDoc2LaTeXProcs.Caption1(cap[1], str);
  fi;
  Append(str, "\\end{center}\n\n");
end;

# do nothing, we call .Caption1 directly in .Table
GAPDoc2LaTeXProcs.Caption := function(r, str)
  return;
end;

# here the caption text is produced
GAPDoc2LaTeXProcs.Caption1 := function(r, str)
  Append(str, Concatenation("\\textbf{", GAPDocTexts.d.Table, ": }"));
  GAPDoc2LaTeXContent(r, str);
end;

GAPDoc2LaTeXProcs.HorLine := function(r, str)
  Append(str, "\\hline\n");
end;

GAPDoc2LaTeXProcs.Row := function(r, str)
  local i, l;
  l := Filtered(r.content, a-> a.name = "Item");
  for i in [1..Length(l)-1] do
    GAPDoc2LaTeXContent(l[i], str);
    Append(str, "&\n");
  od;
  GAPDoc2LaTeXContent(l[Length(l)], str);
  Append(str, "\\\\\n");
end;

GAPDoc2LaTeXProcs.Alt := function(r, str)
  local take, types;
  take := false;
  if IsBound(r.attributes.Only) then
    NormalizeWhitespace(r.attributes.Only);
    types := SplitString(r.attributes.Only, "", " ,");
    if "LaTeX" in types or "BibTeX" in types then
      take := true;
      GAPDoc2LaTeXProcs.recode := false;
    fi;
  fi;
  if IsBound(r.attributes.Not) then
    NormalizeWhitespace(r.attributes.Not);
    types := SplitString(r.attributes.Not, "", " ,");
    if not "LaTeX" in types then
      take := true;
    fi;
  fi;
  if take then
    GAPDoc2LaTeXContent(r, str);
  fi;
  GAPDoc2LaTeXProcs.recode := true;
end;

# copy a few entries with two element names
GAPDoc2LaTeXProcs.E := GAPDoc2LaTeXProcs.Emph;
GAPDoc2LaTeXProcs.Keyword := GAPDoc2LaTeXProcs.K;
GAPDoc2LaTeXProcs.Code := GAPDoc2LaTeXProcs.C;
GAPDoc2LaTeXProcs.File := GAPDoc2LaTeXProcs.F;
GAPDoc2LaTeXProcs.Button := GAPDoc2LaTeXProcs.B;
GAPDoc2LaTeXProcs.Arg := GAPDoc2LaTeXProcs.A;
GAPDoc2LaTeXProcs.Quoted := GAPDoc2LaTeXProcs.Q;
GAPDoc2LaTeXProcs.Par := GAPDoc2LaTeXProcs.P;

