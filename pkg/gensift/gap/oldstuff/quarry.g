#############################################################################
# Old Stuff, maybe no longer necessary:
#############################################################################

BasicSiftExhaustiveSearch := function(sr,g,eps)
  # This seems not to be needed, because BasicSiftCosetReps is better.
  # Please ignore.
  # Does one BasicSift step using exhaustive search. We conduct an orbit
  # algorithm using sr.group to find in g * sr.group an element fulfilling
  # the membership test. eps is ignored.
  local TraceSchreierVector,gens,h,i,l,s,slp,sv,x;

  TraceSchreierVector := function(sv,i)
      # traces back in the Schreier vector to find a straight line program
      # calculating the i the group element from the generators.
      # Returns the one line of the straight line program.
      local j,l,ll;
      l := [];  # We collect from the back and reverse in the end
      while i > 1 do
          Add(l,sv[i][2]);
          i := sv[i][1];
      od;
      l := Reversed(l);
      # Now optimize using powers:
      ll := [];
      i := 1;
      while i <= Length(l) do
          j := i+1;
          while j <= Length(l) and l[j] = l[i] do
              j := j + 1;
          od;
          Add(ll,[l[i],j-i]);
          i := j;
      od;
      return ll;
  end;

  # First check, whether we are already where we want to be:
  if sr.ismember.method( sr.ismember, sr.subgp, g, eps ) then
      return [ One(g), StraightLineProgram( [ [[1,0]] ],2 ) ];
  fi;
  gens := GeneratorsOfGroup(sr.group);
  l := [g];
  sv := [0];   # the Schreier vector
  s := [g];    # a set for faster lookup
  i := 1;
  while i <= Length(l) do
      for h in [1..Length(gens)] do
          x := l[i] * gens[h];
          if sr.ismember.method( sr.ismember, sr.subgp, x, eps ) then
              Add(sv,[i,h]);
              slp := StraightLineProgram(
                        TraceSchreierVector(sv,Length(sv)),
                        Length(gens));
              return [ResultOfStraightLineProgram(slp,gens),slp];
          fi;
          if not(x in s) then
              Add(l,x);
              AddSet(s,x);
              Add(sv,[i,h]);
          fi;
      od;
      i := i + 1;
  od;
  return fail;   #  should never happen
end;


SillyFindShortEl := function(G,f,exc)
  # Trivial method to find a short word in the generators of G fullfilling
  # a condition coded in the function f. exc must be a set of exceptions,
  # which do not count
  local g,gens,i,l,orb,set,wo,x;
  gens := GeneratorsOfGroup(G);
  l := Length(gens);
  #used to be: orb := List([1..l],i->[gens[i],[i]]);
  orb := [[One(G),[]]];
  if not(One(G) in exc) and f(One(G)) then
      return orb[1];
  fi;
  set := [One(G)];
  i := 1;
  while i <= Length(orb) do
      for g in [1..l] do
          x := orb[i][1] * gens[g];
          if not(x in exc) and f(x) then
              Add(orb[i][2],g);
              orb[i][1] := x;
              return orb[i];
          fi;
          if not(x in set) then
              AddSet(set,x);
              wo := ShallowCopy(orb[i][2]);
              Add(wo,g);
              Add(orb,[x,wo]);
          fi;
      od;
      i := i + 1;
  od;
  Error("Found no element in group satisfying condition!");
end;

VerySillyFindGeneratorsSubgroup := function(G,U)
  # Very trivial method to find generators for a subgroup which are
  # short words in the generators of G.
  local exc,s,si,su,subgens,x;
  subgens := [];
  su := Size(U);
  si := 1;
  exc := [One(U)];
  while true do   # return jumps out
    x := SillyFindShortEl(G,x->x in U,exc);
    Add(subgens,x);
    s := Size(Group(List(subgens,y->y[1])));
    if s = su then
        return subgens;
    fi;
    AddSet(exc,x[1]);
    if s = si then
        Unbind(subgens[Length(subgens)]);
    else
        si := s;
        Print("Found subgroup of size ",si,":",List(subgens,x->x[2]),"\n");
    fi;
  od;
end;

TryLeavingOutGenerators := function(SizeU,gens)
  # This uses the result from VerySillyFindGeneratorsSubgroup
  # gens must be in the same format
  local i,l,shortest,ss,try;
  l := Length(gens);
  shortest := gens;
  for i in [1..l] do
      ss := Difference([1..l],[i]);
      try := gens{ss};
      if Size(Group(List(try,x->x[1]))) = SizeU then
          try := TryLeavingOutGenerators(SizeU,try);
          if Length(try) < Length(shortest) then
              shortest := try;
          fi;
      fi;
  od;
  return shortest;
end;
      
CalcC := function( k,n )
  # Calculates a magical constant coming from the analysis of
  # BasicSiftCosetReps. k must be bigger than n, both positive integers.
  local i,j,prod,sum;
  sum := 0;
  for i in [1..k-n] do
      prod := 1;
      for j in [0..i-1] do
          prod := prod * (k-j-n) / (k-j);
      od;
      sum := sum + prod;
  od;
  return sum;
end;

        [StraightLineProgram( [ [ [ 1, 1 ], 3 ], [ [ 2, 1 ], 4 ], 
          [ [ 3,1,4,1 ],5 ],[ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],
          [ [ 4,1,7,1 ],8 ],[ [ 5,1,7,1 ],9 ],[ [ 9,1,5,1 ],10 ],
          [ [ 10,1,10,1 ],11 ],[ [ 10,1,11,1 ],4 ],[ [ 9,15 ],5 ],
          [ [ 5,-1 ],6 ],[ [ 5,1,3,1 ],7 ],[ [ 7,1,6,1 ],3 ],
          [ [ 8,12 ],11 ],[ [ 11,-1 ],10 ],[ [ 10,1,4,1 ],5 ],
          [ [ 5,1,11,1 ],4 ],[ [ 3,1 ],12 ],[ [ 4,1 ],13 ],
          [ [ 12,1 ],3 ],[ [ 13,1 ],4 ],[ [ 3,1,4,1 ],5 ],
          [ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],[ [ 5,1,7,1 ],8 ],
          [ [ 8,1,5,1 ],9 ],[ [ 8,1,9,1 ],10 ],[ [ 10,12 ],3 ],
          [ [ 7,3 ],4 ],[ [ 6,3 ],7 ],[ [ 7,-1 ],8 ],[ [ 8,1,4,1 ],9 ],
          [ [ 9,1,7,1 ],4 ],[ [ 5,-1 ],6 ],[ [ 6,1,3,1 ],7 ],
          [ [ 7,1,5,1 ],3 ],[ [ 3,1 ],14 ],[ [ 4,1 ],15 ],[ [ 14,1 ],3 ],
          [ [ 15,1 ],4 ],[ [ 3,1,4,1 ],5 ],[ 1,1,2,2 ],[ 1,1,2,1 ],
          [ [ 1,1 ],18 ],[ [ 2,1 ],19 ],[ [ 18,1,19,1 ],20 ],
          [ [ 20,1,19,1 ],21 ],[ [ 20,1,21,1 ],22 ],
          [ [ 19,1,22,1 ],23 ],[ [ 20,1,22,1 ],24 ],
          [ [ 24,1,20,1 ],25 ],[ [ 25,1,25,1 ],26 ],
          [ [ 25,1,26,1 ],19 ],[ [ 24,15 ],20 ],[ [ 20,-1 ],21 ],
          [ [ 20,1,18,1 ],22 ],[ [ 22,1,21,1 ],18 ],[ [ 23,12 ],26 ],
          [ [ 26,-1 ],25 ],[ [ 25,1,19,1 ],20 ],[ [ 20,1,26,1 ],19 ],
          [ [ 18,1 ],27 ],[ [ 19,1 ],28 ],[ [ 27,1 ],18 ],[ [ 28,1 ],19 ],
          [ [ 18,1,19,1 ],20 ],[ [ 20,1,19,1 ],21 ],
          [ [ 20,1,21,1 ],22 ],[ [ 20,1,22,1 ],23 ],
          [ [ 23,1,20,1 ],24 ],[ [ 23,1,24,1 ],25 ],[ [ 25,12 ],18 ],
          [ [ 22,3 ],19 ],[ [ 21,3 ],22 ],[ [ 22,-1 ],23 ],
          [ [ 23,1,19,1 ],24 ],[ [ 24,1,22,1 ],19 ],[ [ 20,-1 ],21 ],
          [ [ 21,1,18,1 ],22 ],[ [ 22,1,20,1 ],18 ],[ [ 18,1 ],29 ],
          [ [ 19,1 ],30 ],[ [ 29,1 ],18 ],[ [ 30,1 ],19 ],[ [ 1,1 ],31 ],
          [ [ 2,1 ],32 ],[ [ 31,1,32,1 ],33 ],[ [ 33,1,32,1 ],34 ],
          [ [ 33,1,34,1 ],35 ],[ [ 32,1,35,1 ],36 ],
          [ [ 33,1,35,1 ],37 ],[ [ 37,1,33,1 ],38 ],
          [ [ 38,1,38,1 ],39 ],[ [ 38,1,39,1 ],32 ],[ [ 37,15 ],33 ],
          [ [ 33,-1 ],34 ],[ [ 33,1,31,1 ],35 ],[ [ 35,1,34,1 ],31 ],
          [ [ 36,12 ],39 ],[ [ 39,-1 ],38 ],[ [ 38,1,32,1 ],33 ],
          [ [ 33,1,39,1 ],32 ],[ [ 31,1 ],40 ],[ [ 32,1 ],41 ],
          [ [ 40,1 ],31 ],[ [ 41,1 ],32 ],[ [ 31,1,32,1 ],33 ],
          [ [ 33,1,32,1 ],34 ],[ [ 33,1,34,1 ],35 ],
          [ [ 33,1,35,1 ],36 ],[ [ 36,1,33,1 ],37 ],
          [ [ 36,1,37,1 ],38 ],[ [ 38,12 ],31 ],[ [ 35,3 ],32 ],
          [ [ 34,3 ],35 ],[ [ 35,-1 ],36 ],[ [ 36,1,32,1 ],37 ],
          [ [ 37,1,35,1 ],32 ],[ [ 33,-1 ],34 ],[ [ 34,1,31,1 ],35 ],
          [ [ 35,1,33,1 ],31 ],[ [ 31,1 ],42 ],[ [ 32,1 ],43 ],
          [ [ 42,1 ],31 ],[ [ 43,1 ],32 ],[ [ 31,1,32,1 ],33 ],
          [ [ 33,1,32,1 ],34 ],[ [ 33,1,34,1 ],31 ],
          [ [ 34,1,33,1 ],32 ],[ [ 31,7 ],33 ],[ [ 32,7 ],34 ],
          [ [ 33,1,34,1 ],35 ],[ [ 35,1,35,1 ],33 ],[ [ 33,-1 ],34 ],
          [ [ 34,1,32,1 ],35 ],[ [ 35,1,33,1 ],32 ],[ [ 31,1 ],36 ],
          [ [ 32,1 ],37 ],[ [ 36,1 ],31 ],[ [ 37,1 ],32 ],
          [ [ 16,3,17,2,19,3,18,1,19,2,18,1,19,1,32,3,31,1,32,1,
              31,1 ],33 ],[ 33,-1,5,11,33,1 ] ],2 ),1],
        [StraightLineProgram( [ [ [ 1,1 ],3 ],[ [ 2,1 ],4 ],
          [ [ 3,1,4,1 ],5 ],[ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],
          [ [ 4,1,7,1 ],8 ],[ [ 5,1,7,1 ],9 ],[ [ 9,1,5,1 ],10 ],
          [ [ 10,1,10,1 ],11 ],[ [ 10,1,11,1 ],4 ],[ [ 9,15 ],5 ],
          [ [ 5,-1 ],6 ],[ [ 5,1,3,1 ],7 ],[ [ 7,1,6,1 ],3 ],
          [ [ 8,12 ],11 ],[ [ 11,-1 ],10 ],[ [ 10,1,4,1 ],5 ],
          [ [ 5,1,11,1 ],4 ],[ [ 3,1 ],12 ],[ [ 4,1 ],13 ],
          [ [ 12,1 ],3 ],[ [ 13,1 ],4 ],[ [ 3,1,4,1 ],5 ],
          [ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],[ [ 5,1,7,1 ],8 ],
          [ [ 8,1,5,1 ],9 ],[ [ 8,1,9,1 ],10 ],[ [ 10,12 ],3 ],
          [ [ 7,3 ],4 ],[ [ 6,3 ],7 ],[ [ 7,-1 ],8 ],[ [ 8,1,4,1 ],9 ],
          [ [ 9,1,7,1 ],4 ],[ [ 5,-1 ],6 ],[ [ 6,1,3,1 ],7 ],
          [ [ 7,1,5,1 ],3 ],[ [ 3,1 ],14 ],[ [ 4,1 ],15 ],[ [ 14,1 ],3 ],
          [ [ 15,1 ],4 ],[ [ 3,1,4,1 ],5 ],[ 1,1,2,2 ],[ 1,1,2,1 ],
          [ [ 1,1 ],18 ],[ [ 2,1 ],19 ],[ [ 18,1,19,1 ],20 ],
          [ [ 20,1,19,1 ],21 ],[ [ 20,1,21,1 ],22 ],
          [ [ 19,1,22,1 ],23 ],[ [ 20,1,22,1 ],24 ],
          [ [ 24,1,20,1 ],25 ],[ [ 25,1,25,1 ],26 ],
          [ [ 25,1,26,1 ],19 ],[ [ 24,15 ],20 ],[ [ 20,-1 ],21 ],
          [ [ 20,1,18,1 ],22 ],[ [ 22,1,21,1 ],18 ],[ [ 23,12 ],26 ],
          [ [ 26,-1 ],25 ],[ [ 25,1,19,1 ],20 ],[ [ 20,1,26,1 ],19 ],
          [ [ 18,1 ],27 ],[ [ 19,1 ],28 ],[ [ 27,1 ],18 ],[ [ 28,1 ],19 ],
          [ [ 18,1,19,1 ],20 ],[ [ 20,1,19,1 ],21 ],
          [ [ 20,1,21,1 ],22 ],[ [ 20,1,22,1 ],23 ],
          [ [ 23,1,20,1 ],24 ],[ [ 23,1,24,1 ],25 ],[ [ 25,12 ],18 ],
          [ [ 22,3 ],19 ],[ [ 21,3 ],22 ],[ [ 22,-1 ],23 ],
          [ [ 23,1,19,1 ],24 ],[ [ 24,1,22,1 ],19 ],[ [ 20,-1 ],21 ],
          [ [ 21,1,18,1 ],22 ],[ [ 22,1,20,1 ],18 ],[ [ 18,1 ],29 ],
          [ [ 19,1 ],30 ],[ [ 29,1 ],18 ],[ [ 30,1 ],19 ],[ [ 1,1 ],31 ],
          [ [ 2,1 ],32 ],[ [ 31,1,32,1 ],33 ],[ [ 33,1,32,1 ],34 ],
          [ [ 33,1,34,1 ],35 ],[ [ 32,1,35,1 ],36 ],
          [ [ 33,1,35,1 ],37 ],[ [ 37,1,33,1 ],38 ],
          [ [ 38,1,38,1 ],39 ],[ [ 38,1,39,1 ],32 ],[ [ 37,15 ],33 ],
          [ [ 33,-1 ],34 ],[ [ 33,1,31,1 ],35 ],[ [ 35,1,34,1 ],31 ],
          [ [ 36,12 ],39 ],[ [ 39,-1 ],38 ],[ [ 38,1,32,1 ],33 ],
          [ [ 33,1,39,1 ],32 ],[ [ 31,1 ],40 ],[ [ 32,1 ],41 ],
          [ [ 40,1 ],31 ],[ [ 41,1 ],32 ],[ [ 31,1,32,1 ],33 ],
          [ [ 33,1,32,1 ],34 ],[ [ 33,1,34,1 ],35 ],
          [ [ 33,1,35,1 ],36 ],[ [ 36,1,33,1 ],37 ],
          [ [ 36,1,37,1 ],38 ],[ [ 38,12 ],31 ],[ [ 35,3 ],32 ],
          [ [ 34,3 ],35 ],[ [ 35,-1 ],36 ],[ [ 36,1,32,1 ],37 ],
          [ [ 37,1,35,1 ],32 ],[ [ 33,-1 ],34 ],[ [ 34,1,31,1 ],35 ],
          [ [ 35,1,33,1 ],31 ],[ [ 31,1 ],42 ],[ [ 32,1 ],43 ],
          [ [ 42,1 ],31 ],[ [ 43,1 ],32 ],[ [ 31,1,32,1 ],33 ],
          [ [ 33,1,32,1 ],34 ],[ [ 33,1,34,1 ],31 ],
          [ [ 34,1,33,1 ],32 ],[ [ 31,7 ],33 ],[ [ 32,7 ],34 ],
          [ [ 33,1,34,1 ],35 ],[ [ 35,1,35,1 ],33 ],[ [ 33,-1 ],34 ],
          [ [ 34,1,32,1 ],35 ],[ [ 35,1,33,1 ],32 ],[ [ 31,1 ],36 ],
          [ [ 32,1 ],37 ],[ [ 36,1 ],31 ],[ [ 37,1 ],32 ],
          [ [ 32,2,31,1,32,1,31,1,32,2 ],33 ],
          [ [ 31,1,32,2,31,2,32,2,31,1 ],34 ],[ [ 33,1 ],31 ],
          [ [ 34,1 ],32 ],
          [ [ 16,3,17,2,19,3,18,1,19,2,18,1,19,1,32,1 ],33 ],
          [ 33,-1,5,11,33,1 ] ],2 ),1],
        [StraightLineProgram( [ [ [ 1,1 ],3 ],[ [ 2,1 ],4 ],
          [ [ 3,1,4,1 ],5 ],[ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],
          [ [ 4,1,7,1 ],8 ],[ [ 5,1,7,1 ],9 ],[ [ 9,1,5,1 ],10 ],
          [ [ 10,1,10,1 ],11 ],[ [ 10,1,11,1 ],4 ],[ [ 9,15 ],5 ],
          [ [ 5,-1 ],6 ],[ [ 5,1,3,1 ],7 ],[ [ 7,1,6,1 ],3 ],
          [ [ 8,12 ],11 ],[ [ 11,-1 ],10 ],[ [ 10,1,4,1 ],5 ],
          [ [ 5,1,11,1 ],4 ],[ [ 3,1 ],12 ],[ [ 4,1 ],13 ],
          [ [ 12,1 ],3 ],[ [ 13,1 ],4 ],[ [ 3,1,4,1 ],5 ],
          [ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],[ [ 5,1,7,1 ],8 ],
          [ [ 8,1,5,1 ],9 ],[ [ 8,1,9,1 ],10 ],[ [ 10,12 ],3 ],
          [ [ 7,3 ],4 ],[ [ 6,3 ],7 ],[ [ 7,-1 ],8 ],[ [ 8,1,4,1 ],9 ],
          [ [ 9,1,7,1 ],4 ],[ [ 5,-1 ],6 ],[ [ 6,1,3,1 ],7 ],
          [ [ 7,1,5,1 ],3 ],[ [ 3,1 ],14 ],[ [ 4,1 ],15 ],[ [ 14,1 ],3 ],
          [ [ 15,1 ],4 ],[ [ 3,1,4,1 ],5 ],[ 1,1,2,2 ],[ 1,1,2,1 ],
          [ [ 1,1 ],18 ],[ [ 2,1 ],19 ],[ [ 18,1,19,1 ],20 ],
          [ [ 20,1,19,1 ],21 ],[ [ 20,1,21,1 ],22 ],
          [ [ 19,1,22,1 ],23 ],[ [ 20,1,22,1 ],24 ],
          [ [ 24,1,20,1 ],25 ],[ [ 25,1,25,1 ],26 ],
          [ [ 25,1,26,1 ],19 ],[ [ 24,15 ],20 ],[ [ 20,-1 ],21 ],
          [ [ 20,1,18,1 ],22 ],[ [ 22,1,21,1 ],18 ],[ [ 23,12 ],26 ],
          [ [ 26,-1 ],25 ],[ [ 25,1,19,1 ],20 ],[ [ 20,1,26,1 ],19 ],
          [ [ 18,1 ],27 ],[ [ 19,1 ],28 ],[ [ 27,1 ],18 ],[ [ 28,1 ],19 ],
          [ [ 18,1,19,1 ],20 ],[ [ 20,1,19,1 ],21 ],
          [ [ 20,1,21,1 ],22 ],[ [ 20,1,22,1 ],23 ],
          [ [ 23,1,20,1 ],24 ],[ [ 23,1,24,1 ],25 ],[ [ 25,12 ],18 ],
          [ [ 22,3 ],19 ],[ [ 21,3 ],22 ],[ [ 22,-1 ],23 ],
          [ [ 23,1,19,1 ],24 ],[ [ 24,1,22,1 ],19 ],[ [ 20,-1 ],21 ],
          [ [ 21,1,18,1 ],22 ],[ [ 22,1,20,1 ],18 ],[ [ 18,1 ],29 ],
          [ [ 19,1 ],30 ],[ [ 29,1 ],18 ],[ [ 30,1 ],19 ],[ [ 1,1 ],31 ],
          [ [ 2,1 ],32 ],[ [ 31,1,32,1 ],33 ],[ [ 33,1,32,1 ],34 ],
          [ [ 33,1,34,1 ],35 ],[ [ 32,1,35,1 ],36 ],
          [ [ 33,1,35,1 ],37 ],[ [ 37,1,33,1 ],38 ],
          [ [ 38,1,38,1 ],39 ],[ [ 38,1,39,1 ],32 ],[ [ 37,15 ],33 ],
          [ [ 33,-1 ],34 ],[ [ 33,1,31,1 ],35 ],[ [ 35,1,34,1 ],31 ],
          [ [ 36,12 ],39 ],[ [ 39,-1 ],38 ],[ [ 38,1,32,1 ],33 ],
          [ [ 33,1,39,1 ],32 ],[ [ 31,1 ],40 ],[ [ 32,1 ],41 ],
          [ [ 40,1 ],31 ],[ [ 41,1 ],32 ],[ [ 31,1,32,1 ],33 ],
          [ [ 33,1,32,1 ],34 ],[ [ 33,1,34,1 ],35 ],
          [ [ 33,1,35,1 ],36 ],[ [ 36,1,33,1 ],37 ],
          [ [ 36,1,37,1 ],38 ],[ [ 38,12 ],31 ],[ [ 35,3 ],32 ],
          [ [ 34,3 ],35 ],[ [ 35,-1 ],36 ],[ [ 36,1,32,1 ],37 ],
          [ [ 37,1,35,1 ],32 ],[ [ 33,-1 ],34 ],[ [ 34,1,31,1 ],35 ],
          [ [ 35,1,33,1 ],31 ],[ [ 31,1 ],42 ],[ [ 32,1 ],43 ],
          [ [ 42,1 ],31 ],[ [ 43,1 ],32 ],[ [ 31,1,32,1 ],33 ],
          [ [ 33,1,32,1 ],34 ],[ [ 33,1,34,1 ],31 ],
          [ [ 34,1,33,1 ],32 ],[ [ 31,7 ],33 ],[ [ 32,7 ],34 ],
          [ [ 33,1,34,1 ],35 ],[ [ 35,1,35,1 ],33 ],[ [ 33,-1 ],34 ],
          [ [ 34,1,32,1 ],35 ],[ [ 35,1,33,1 ],32 ],[ [ 31,1 ],36 ],
          [ [ 32,1 ],37 ],[ [ 36,1 ],31 ],[ [ 37,1 ],32 ],
          [ [ 16,3,17,2,19,3,18,1,19,2,18,1,19,1,32,2,31,1 ],33 ],
          [ 33,-1,5,11,33,1 ] ],2 ),1],
        [StraightLineProgram( [ [ [ 1,1 ],3 ],[ [ 2,1 ],4 ],
          [ [ 3,1,4,1 ],5 ],[ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],
          [ [ 4,1,7,1 ],8 ],[ [ 5,1,7,1 ],9 ],[ [ 9,1,5,1 ],10 ],
          [ [ 10,1,10,1 ],11 ],[ [ 10,1,11,1 ],4 ],[ [ 9,15 ],5 ],
          [ [ 5,-1 ],6 ],[ [ 5,1,3,1 ],7 ],[ [ 7,1,6,1 ],3 ],
          [ [ 8,12 ],11 ],[ [ 11,-1 ],10 ],[ [ 10,1,4,1 ],5 ],
          [ [ 5,1,11,1 ],4 ],[ [ 3,1 ],12 ],[ [ 4,1 ],13 ],
          [ [ 12,1 ],3 ],[ [ 13,1 ],4 ],[ [ 3,1,4,1 ],5 ],
          [ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],[ [ 5,1,7,1 ],8 ],
          [ [ 8,1,5,1 ],9 ],[ [ 8,1,9,1 ],10 ],[ [ 10,12 ],3 ],
          [ [ 7,3 ],4 ],[ [ 6,3 ],7 ],[ [ 7,-1 ],8 ],[ [ 8,1,4,1 ],9 ],
          [ [ 9,1,7,1 ],4 ],[ [ 5,-1 ],6 ],[ [ 6,1,3,1 ],7 ],
          [ [ 7,1,5,1 ],3 ],[ [ 3,1 ],14 ],[ [ 4,1 ],15 ],[ [ 14,1 ],3 ],
          [ [ 15,1 ],4 ],[ [ 3,1,4,1 ],5 ],[ 1,1,2,2 ],[ 1,1,2,1 ],
          [ [ 1,1 ],18 ],[ [ 2,1 ],19 ],[ [ 18,1,19,1 ],20 ],
          [ [ 20,1,19,1 ],21 ],[ [ 20,1,21,1 ],22 ],
          [ [ 19,1,22,1 ],23 ],[ [ 20,1,22,1 ],24 ],
          [ [ 24,1,20,1 ],25 ],[ [ 25,1,25,1 ],26 ],
          [ [ 25,1,26,1 ],19 ],[ [ 24,15 ],20 ],[ [ 20,-1 ],21 ],
          [ [ 20,1,18,1 ],22 ],[ [ 22,1,21,1 ],18 ],[ [ 23,12 ],26 ],
          [ [ 26,-1 ],25 ],[ [ 25,1,19,1 ],20 ],[ [ 20,1,26,1 ],19 ],
          [ [ 18,1 ],27 ],[ [ 19,1 ],28 ],[ [ 27,1 ],18 ],[ [ 28,1 ],19 ],
          [ [ 18,1,19,1 ],20 ],[ [ 20,1,19,1 ],21 ],
          [ [ 20,1,21,1 ],22 ],[ [ 20,1,22,1 ],23 ],
          [ [ 23,1,20,1 ],24 ],[ [ 23,1,24,1 ],25 ],[ [ 25,12 ],18 ],
          [ [ 22,3 ],19 ],[ [ 21,3 ],22 ],[ [ 22,-1 ],23 ],
          [ [ 23,1,19,1 ],24 ],[ [ 24,1,22,1 ],19 ],[ [ 20,-1 ],21 ],
          [ [ 21,1,18,1 ],22 ],[ [ 22,1,20,1 ],18 ],[ [ 18,1 ],29 ],
          [ [ 19,1 ],30 ],[ [ 29,1 ],18 ],[ [ 30,1 ],19 ],[ [ 1,1 ],31 ],
          [ [ 2,1 ],32 ],[ [ 31,1,32,1 ],33 ],[ [ 33,1,32,1 ],34 ],
          [ [ 33,1,34,1 ],35 ],[ [ 32,1,35,1 ],36 ],
          [ [ 33,1,35,1 ],37 ],[ [ 37,1,33,1 ],38 ],
          [ [ 38,1,38,1 ],39 ],[ [ 38,1,39,1 ],32 ],[ [ 37,15 ],33 ],
          [ [ 33,-1 ],34 ],[ [ 33,1,31,1 ],35 ],[ [ 35,1,34,1 ],31 ],
          [ [ 36,12 ],39 ],[ [ 39,-1 ],38 ],[ [ 38,1,32,1 ],33 ],
          [ [ 33,1,39,1 ],32 ],[ [ 31,1 ],40 ],[ [ 32,1 ],41 ],
          [ [ 40,1 ],31 ],[ [ 41,1 ],32 ],[ [ 31,1,32,1 ],33 ],
          [ [ 33,1,32,1 ],34 ],[ [ 33,1,34,1 ],35 ],
          [ [ 33,1,35,1 ],36 ],[ [ 36,1,33,1 ],37 ],
          [ [ 36,1,37,1 ],38 ],[ [ 38,12 ],31 ],[ [ 35,3 ],32 ],
          [ [ 34,3 ],35 ],[ [ 35,-1 ],36 ],[ [ 36,1,32,1 ],37 ],
          [ [ 37,1,35,1 ],32 ],[ [ 33,-1 ],34 ],[ [ 34,1,31,1 ],35 ],
          [ [ 35,1,33,1 ],31 ],[ [ 31,1 ],42 ],[ [ 32,1 ],43 ],
          [ [ 42,1 ],31 ],[ [ 43,1 ],32 ],[ [ 31,1,32,1 ],33 ],
          [ [ 33,1,32,1 ],34 ],[ [ 33,1,34,1 ],31 ],
          [ [ 34,1,33,1 ],32 ],[ [ 31,7 ],33 ],[ [ 32,7 ],34 ],
          [ [ 33,1,34,1 ],35 ],[ [ 35,1,35,1 ],33 ],[ [ 33,-1 ],34 ],
          [ [ 34,1,32,1 ],35 ],[ [ 35,1,33,1 ],32 ],[ [ 31,1 ],36 ],
          [ [ 32,1 ],37 ],[ [ 36,1 ],31 ],[ [ 37,1 ],32 ],
          [ [ 16,3,17,2,19,3,18,1,19,2,18,1,19,1,31,3 ],33 ],
          [ 33,-1,5,11,33,1 ] ],2 ),1]];
      [StraightLineProgram( [ [ [ 1,1 ],3 ],[ [ 2,1 ],4 ],
          [ [ 3,1,4,1 ],5 ],[ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],
          [ [ 4,1,7,1 ],8 ],[ [ 5,1,7,1 ],9 ],[ [ 9,1,5,1 ],10 ],
          [ [ 10,1,10,1 ],11 ],[ [ 10,1,11,1 ],4 ],[ [ 9,15 ],5 ],
          [ [ 5,-1 ],6 ],[ [ 5,1,3,1 ],7 ],[ [ 7,1,6,1 ],3 ],
          [ [ 8,12 ],11 ],[ [ 11,-1 ],10 ],[ [ 10,1,4,1 ],5 ],
          [ [ 5,1,11,1 ],4 ],[ [ 3,1 ],12 ],[ [ 4,1 ],13 ],
          [ [ 12,1 ],3 ],[ [ 13,1 ],4 ],[ [ 3,1,4,1 ],5 ],
          [ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],[ [ 5,1,7,1 ],8 ],
          [ [ 8,1,5,1 ],9 ],[ [ 8,1,9,1 ],10 ],[ [ 10,12 ],3 ],
          [ [ 7,3 ],4 ],[ [ 6,3 ],7 ],[ [ 7,-1 ],8 ],[ [ 8,1,4,1 ],9 ],
          [ [ 9,1,7,1 ],4 ],[ [ 5,-1 ],6 ],[ [ 6,1,3,1 ],7 ],
          [ [ 7,1,5,1 ],3 ],[ [ 3,1 ],14 ],[ [ 4,1 ],15 ],[ [ 14,1 ],3 ],
          [ [ 15,1 ],4 ],[ [ 3,1,4,3 ],5 ],[ [ 3,1,4,1 ],6 ],
          [ [ 1,1 ],16 ],[ [ 2,1 ],17 ],[ [ 16,1,17,1 ],18 ],
          [ [ 18,1,17,1 ],19 ],[ [ 18,1,19,1 ],20 ],
          [ [ 17,1,20,1 ],21 ],[ [ 18,1,20,1 ],22 ],
          [ [ 22,1,18,1 ],23 ],[ [ 23,1,23,1 ],24 ],
          [ [ 23,1,24,1 ],17 ],[ [ 22,15 ],18 ],[ [ 18,-1 ],19 ],
          [ [ 18,1,16,1 ],20 ],[ [ 20,1,19,1 ],16 ],[ [ 21,12 ],24 ],
          [ [ 24,-1 ],23 ],[ [ 23,1,17,1 ],18 ],[ [ 18,1,24,1 ],17 ],
          [ [ 16,1 ],25 ],[ [ 17,1 ],26 ],[ [ 25,1 ],16 ],[ [ 26,1 ],17 ],
          [ [ 16,1,17,1 ],18 ],[ [ 18,1,17,1 ],19 ],
          [ [ 18,1,19,1 ],20 ],[ [ 18,1,20,1 ],21 ],
          [ [ 21,1,18,1 ],22 ],[ [ 21,1,22,1 ],23 ],[ [ 23,12 ],16 ],
          [ [ 20,3 ],17 ],[ [ 19,3 ],20 ],[ [ 20,-1 ],21 ],
          [ [ 21,1,17,1 ],22 ],[ [ 22,1,20,1 ],17 ],[ [ 18,-1 ],19 ],
          [ [ 19,1,16,1 ],20 ],[ [ 20,1,18,1 ],16 ],[ [ 16,1 ],27 ],
          [ [ 17,1 ],28 ],[ [ 27,1 ],16 ],[ [ 28,1 ],17 ],
          [ [ 16,1,17,1 ],18 ],[ [ 18,1,17,1 ],19 ],
          [ [ 18,1,19,1 ],16 ],[ [ 19,1,18,1 ],17 ],[ [ 16,7 ],18 ],
          [ [ 17,7 ],19 ],[ [ 18,1,19,1 ],20 ],[ [ 20,1,20,1 ],18 ],
          [ [ 18,-1 ],19 ],[ [ 19,1,17,1 ],20 ],[ [ 20,1,18,1 ],17 ],
          [ [ 16,1 ],21 ],[ [ 17,1 ],22 ],[ [ 21,1 ],16 ],[ [ 22,1 ],17 ],
          [ 16,-2,5,-1,6,-2,5,-1,4,-1,6,-1,5,-1 ] ],2 ),1],
      [StraightLineProgram( [ [ [ 1,1 ],3 ],[ [ 2,1 ],4 ],
          [ [ 3,1,4,1 ],5 ],[ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],
          [ [ 4,1,7,1 ],8 ],[ [ 5,1,7,1 ],9 ],[ [ 9,1,5,1 ],10 ],
          [ [ 10,1,10,1 ],11 ],[ [ 10,1,11,1 ],4 ],[ [ 9,15 ],5 ],
          [ [ 5,-1 ],6 ],[ [ 5,1,3,1 ],7 ],[ [ 7,1,6,1 ],3 ],
          [ [ 8,12 ],11 ],[ [ 11,-1 ],10 ],[ [ 10,1,4,1 ],5 ],
          [ [ 5,1,11,1 ],4 ],[ [ 3,1 ],12 ],[ [ 4,1 ],13 ],
          [ [ 12,1 ],3 ],[ [ 13,1 ],4 ],[ [ 3,1,4,1 ],5 ],
          [ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],[ [ 5,1,7,1 ],8 ],
          [ [ 8,1,5,1 ],9 ],[ [ 8,1,9,1 ],10 ],[ [ 10,12 ],3 ],
          [ [ 7,3 ],4 ],[ [ 6,3 ],7 ],[ [ 7,-1 ],8 ],[ [ 8,1,4,1 ],9 ],
          [ [ 9,1,7,1 ],4 ],[ [ 5,-1 ],6 ],[ [ 6,1,3,1 ],7 ],
          [ [ 7,1,5,1 ],3 ],[ [ 3,1 ],14 ],[ [ 4,1 ],15 ],[ [ 14,1 ],3 ],
          [ [ 15,1 ],4 ],[ [ 1,1 ],16 ],[ [ 2,1 ],17 ],
          [ [ 16,1,17,1 ],18 ],[ [ 18,1,17,1 ],19 ],
          [ [ 18,1,19,1 ],20 ],[ [ 17,1,20,1 ],21 ],
          [ [ 18,1,20,1 ],22 ],[ [ 22,1,18,1 ],23 ],
          [ [ 23,1,23,1 ],24 ],[ [ 23,1,24,1 ],17 ],[ [ 22,15 ],18 ],
          [ [ 18,-1 ],19 ],[ [ 18,1,16,1 ],20 ],[ [ 20,1,19,1 ],16 ],
          [ [ 21,12 ],24 ],[ [ 24,-1 ],23 ],[ [ 23,1,17,1 ],18 ],
          [ [ 18,1,24,1 ],17 ],[ [ 16,1 ],25 ],[ [ 17,1 ],26 ],
          [ [ 25,1 ],16 ],[ [ 26,1 ],17 ],[ [ 16,1,17,1 ],18 ],
          [ [ 18,1,17,1 ],19 ],[ [ 18,1,19,1 ],20 ],
          [ [ 18,1,20,1 ],21 ],[ [ 21,1,18,1 ],22 ],
          [ [ 21,1,22,1 ],23 ],[ [ 23,12 ],16 ],[ [ 20,3 ],17 ],
          [ [ 19,3 ],20 ],[ [ 20,-1 ],21 ],[ [ 21,1,17,1 ],22 ],
          [ [ 22,1,20,1 ],17 ],[ [ 18,-1 ],19 ],[ [ 19,1,16,1 ],20 ],
          [ [ 20,1,18,1 ],16 ],[ [ 16,1 ],27 ],[ [ 17,1 ],28 ],
          [ [ 27,1 ],16 ],[ [ 28,1 ],17 ],[ [ 16,1,17,1 ],18 ],
          [ [ 18,1,17,1 ],19 ],[ [ 18,1,19,1 ],16 ],
          [ [ 19,1,18,1 ],17 ],[ [ 16,7 ],18 ],[ [ 17,7 ],19 ],
          [ [ 18,1,19,1 ],20 ],[ [ 20,1,20,1 ],18 ],[ [ 18,-1 ],19 ],
          [ [ 19,1,17,1 ],20 ],[ [ 20,1,18,1 ],17 ],[ [ 16,1 ],21 ],
          [ [ 17,1 ],22 ],[ [ 21,1 ],16 ],[ [ 22,1 ],17 ],
          [ [ 17,2,16,1,17,1,16,1,17,2 ],18 ],
          [ [ 16,1,17,2,16,2,17,2,16,1 ],19 ],[ [ 18,1 ],16 ],
          [ [ 19,1 ],17 ],[ 17,-1,4,-1,3,-1,4,-2,3,-1,4,-3 ] ],2 ),1],
      [StraightLineProgram( [ [ [ 1,1 ],3 ],[ [ 2,1 ],4 ],
          [ [ 3,1,4,1 ],5 ],[ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],
          [ [ 4,1,7,1 ],8 ],[ [ 5,1,7,1 ],9 ],[ [ 9,1,5,1 ],10 ],
          [ [ 10,1,10,1 ],11 ],[ [ 10,1,11,1 ],4 ],[ [ 9,15 ],5 ],
          [ [ 5,-1 ],6 ],[ [ 5,1,3,1 ],7 ],[ [ 7,1,6,1 ],3 ],
          [ [ 8,12 ],11 ],[ [ 11,-1 ],10 ],[ [ 10,1,4,1 ],5 ],
          [ [ 5,1,11,1 ],4 ],[ [ 3,1 ],12 ],[ [ 4,1 ],13 ],
          [ [ 12,1 ],3 ],[ [ 13,1 ],4 ],[ [ 3,1,4,1 ],5 ],
          [ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],[ [ 5,1,7,1 ],8 ],
          [ [ 8,1,5,1 ],9 ],[ [ 8,1,9,1 ],10 ],[ [ 10,12 ],3 ],
          [ [ 7,3 ],4 ],[ [ 6,3 ],7 ],[ [ 7,-1 ],8 ],[ [ 8,1,4,1 ],9 ],
          [ [ 9,1,7,1 ],4 ],[ [ 5,-1 ],6 ],[ [ 6,1,3,1 ],7 ],
          [ [ 7,1,5,1 ],3 ],[ [ 3,1 ],14 ],[ [ 4,1 ],15 ],[ [ 14,1 ],3 ],
          [ [ 15,1 ],4 ],[ [ 4,1,3,1 ],5 ],[ [ 1,1 ],16 ],[ [ 2,1 ],17 ],
          [ [ 16,1,17,1 ],18 ],[ [ 18,1,17,1 ],19 ],
          [ [ 18,1,19,1 ],20 ],[ [ 17,1,20,1 ],21 ],
          [ [ 18,1,20,1 ],22 ],[ [ 22,1,18,1 ],23 ],
          [ [ 23,1,23,1 ],24 ],[ [ 23,1,24,1 ],17 ],[ [ 22,15 ],18 ],
          [ [ 18,-1 ],19 ],[ [ 18,1,16,1 ],20 ],[ [ 20,1,19,1 ],16 ],
          [ [ 21,12 ],24 ],[ [ 24,-1 ],23 ],[ [ 23,1,17,1 ],18 ],
          [ [ 18,1,24,1 ],17 ],[ [ 16,1 ],25 ],[ [ 17,1 ],26 ],
          [ [ 25,1 ],16 ],[ [ 26,1 ],17 ],[ [ 16,1,17,1 ],18 ],
          [ [ 18,1,17,1 ],19 ],[ [ 18,1,19,1 ],20 ],
          [ [ 18,1,20,1 ],21 ],[ [ 21,1,18,1 ],22 ],
          [ [ 21,1,22,1 ],23 ],[ [ 23,12 ],16 ],[ [ 20,3 ],17 ],
          [ [ 19,3 ],20 ],[ [ 20,-1 ],21 ],[ [ 21,1,17,1 ],22 ],
          [ [ 22,1,20,1 ],17 ],[ [ 18,-1 ],19 ],[ [ 19,1,16,1 ],20 ],
          [ [ 20,1,18,1 ],16 ],[ [ 16,1 ],27 ],[ [ 17,1 ],28 ],
          [ [ 27,1 ],16 ],[ [ 28,1 ],17 ],[ [ 16,1,17,1 ],18 ],
          [ [ 18,1,17,1 ],19 ],[ [ 18,1,19,1 ],16 ],
          [ [ 19,1,18,1 ],17 ],[ [ 16,7 ],18 ],[ [ 17,7 ],19 ],
          [ [ 18,1,19,1 ],20 ],[ [ 20,1,20,1 ],18 ],[ [ 18,-1 ],19 ],
          [ [ 19,1,17,1 ],20 ],[ [ 20,1,18,1 ],17 ],[ [ 16,1 ],21 ],
          [ [ 17,1 ],22 ],[ [ 21,1 ],16 ],[ [ 22,1 ],17 ],[ [ 1,1 ],29 ],
          [ [ 2,1 ],30 ],[ [ 29,1,30,1 ],31 ],[ [ 31,1,30,1 ],32 ],
          [ [ 31,1,32,1 ],33 ],[ [ 30,1,33,1 ],34 ],
          [ [ 31,1,33,1 ],35 ],[ [ 35,1,31,1 ],36 ],
          [ [ 36,1,36,1 ],37 ],[ [ 36,1,37,1 ],30 ],[ [ 35,15 ],31 ],
          [ [ 31,-1 ],32 ],[ [ 31,1,29,1 ],33 ],[ [ 33,1,32,1 ],29 ],
          [ [ 34,12 ],37 ],[ [ 37,-1 ],36 ],[ [ 36,1,30,1 ],31 ],
          [ [ 31,1,37,1 ],30 ],[ [ 29,1 ],38 ],[ [ 30,1 ],39 ],
          [ [ 38,1 ],29 ],[ [ 39,1 ],30 ],[ [ 29,1,30,1 ],31 ],
          [ [ 31,1,30,1 ],32 ],[ [ 31,1,32,1 ],33 ],
          [ [ 31,1,33,1 ],34 ],[ [ 34,1,31,1 ],35 ],
          [ [ 34,1,35,1 ],36 ],[ [ 36,12 ],29 ],[ [ 33,3 ],30 ],
          [ [ 32,3 ],33 ],[ [ 33,-1 ],34 ],[ [ 34,1,30,1 ],35 ],
          [ [ 35,1,33,1 ],30 ],[ [ 31,-1 ],32 ],[ [ 32,1,29,1 ],33 ],
          [ [ 33,1,31,1 ],29 ],[ [ 29,1 ],40 ],[ [ 30,1 ],41 ],
          [ [ 40,1 ],29 ],[ [ 41,1 ],30 ],[ [ 29,1,30,1 ],31 ],
          [ [ 31,1,30,1 ],32 ],[ [ 31,1,32,1 ],29 ],
          [ [ 32,1,31,1 ],30 ],[ [ 29,7 ],31 ],[ [ 30,7 ],32 ],
          [ [ 31,1,32,1 ],33 ],[ [ 33,1,33,1 ],31 ],[ [ 31,-1 ],32 ],
          [ [ 32,1,30,1 ],33 ],[ [ 33,1,31,1 ],30 ],[ [ 29,1 ],34 ],
          [ [ 30,1 ],35 ],[ [ 34,1 ],29 ],[ [ 35,1 ],30 ],
          [ [ 30,2,29,1,30,1,29,1,30,2 ],31 ],
          [ [ 29,1,30,2,29,2,30,2,29,1 ],32 ],[ [ 31,1 ],29 ],
          [ [ 32,1 ],30 ],
          [ 29,-1,30,-1,17,-1,4,-1,3,-1,4,-2,3,-1,4,-2,5,-3 ] ],2 ),1],
      [StraightLineProgram( [ [ [ 1,1 ],3 ],[ [ 2,1 ],4 ],
          [ [ 3,1,4,1 ],5 ],[ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],
          [ [ 4,1,7,1 ],8 ],[ [ 5,1,7,1 ],9 ],[ [ 9,1,5,1 ],10 ],
          [ [ 10,1,10,1 ],11 ],[ [ 10,1,11,1 ],4 ],[ [ 9,15 ],5 ],
          [ [ 5,-1 ],6 ],[ [ 5,1,3,1 ],7 ],[ [ 7,1,6,1 ],3 ],
          [ [ 8,12 ],11 ],[ [ 11,-1 ],10 ],[ [ 10,1,4,1 ],5 ],
          [ [ 5,1,11,1 ],4 ],[ [ 3,1 ],12 ],[ [ 4,1 ],13 ],
          [ [ 12,1 ],3 ],[ [ 13,1 ],4 ],[ [ 3,1,4,1 ],5 ],
          [ [ 5,1,4,1 ],6 ],[ [ 5,1,6,1 ],7 ],[ [ 5,1,7,1 ],8 ],
          [ [ 8,1,5,1 ],9 ],[ [ 8,1,9,1 ],10 ],[ [ 10,12 ],3 ],
          [ [ 7,3 ],4 ],[ [ 6,3 ],7 ],[ [ 7,-1 ],8 ],[ [ 8,1,4,1 ],9 ],
          [ [ 9,1,7,1 ],4 ],[ [ 5,-1 ],6 ],[ [ 6,1,3,1 ],7 ],
          [ [ 7,1,5,1 ],3 ],[ [ 3,1 ],14 ],[ [ 4,1 ],15 ],[ [ 14,1 ],3 ],
          [ [ 15,1 ],4 ],[ [ 4,1,3,1 ],5 ],[ [ 1,1 ],16 ],[ [ 2,1 ],17 ],
          [ [ 16,1,17,1 ],18 ],[ [ 18,1,17,1 ],19 ],
          [ [ 18,1,19,1 ],20 ],[ [ 17,1,20,1 ],21 ],
          [ [ 18,1,20,1 ],22 ],[ [ 22,1,18,1 ],23 ],
          [ [ 23,1,23,1 ],24 ],[ [ 23,1,24,1 ],17 ],[ [ 22,15 ],18 ],
          [ [ 18,-1 ],19 ],[ [ 18,1,16,1 ],20 ],[ [ 20,1,19,1 ],16 ],
          [ [ 21,12 ],24 ],[ [ 24,-1 ],23 ],[ [ 23,1,17,1 ],18 ],
          [ [ 18,1,24,1 ],17 ],[ [ 16,1 ],25 ],[ [ 17,1 ],26 ],
          [ [ 25,1 ],16 ],[ [ 26,1 ],17 ],[ [ 16,1,17,1 ],18 ],
          [ [ 18,1,17,1 ],19 ],[ [ 18,1,19,1 ],20 ],
          [ [ 18,1,20,1 ],21 ],[ [ 21,1,18,1 ],22 ],
          [ [ 21,1,22,1 ],23 ],[ [ 23,12 ],16 ],[ [ 20,3 ],17 ],
          [ [ 19,3 ],20 ],[ [ 20,-1 ],21 ],[ [ 21,1,17,1 ],22 ],
          [ [ 22,1,20,1 ],17 ],[ [ 18,-1 ],19 ],[ [ 19,1,16,1 ],20 ],
          [ [ 20,1,18,1 ],16 ],[ [ 16,1 ],27 ],[ [ 17,1 ],28 ],
          [ [ 27,1 ],16 ],[ [ 28,1 ],17 ],[ [ 16,1,17,1 ],18 ],
          [ [ 18,1,17,1 ],19 ],[ [ 18,1,19,1 ],16 ],
          [ [ 19,1,18,1 ],17 ],[ [ 16,7 ],18 ],[ [ 17,7 ],19 ],
          [ [ 18,1,19,1 ],20 ],[ [ 20,1,20,1 ],18 ],[ [ 18,-1 ],19 ],
          [ [ 19,1,17,1 ],20 ],[ [ 20,1,18,1 ],17 ],[ [ 16,1 ],21 ],
          [ [ 17,1 ],22 ],[ [ 21,1 ],16 ],[ [ 22,1 ],17 ],
          [ 16,-2,4,-2,5,-3,4,-1,3,-1,4,-3 ] ],2 ),1]],