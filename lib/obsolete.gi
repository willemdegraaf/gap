#############################################################################
##
#W  obsolete.gi                  GAP library                     Steve Linton
##
#H  @(#)$Id: obsolete.gi,v 4.2 2010/08/02 16:36:55 alexk Exp $
##
#Y  Copyright (C)  1996,  Lehrstuhl D für Mathematik,  RWTH Aachen,  Germany
#Y  (C) 1998 School Math and Comp. Sci., University of St Andrews, Scotland
#Y  Copyright (C) 2002 The GAP Group
##
##  See the comments in `lib/obsolete.gd'.
##
Revision.obsolete_gi :=
    "@(#)$Id: obsolete.gi,v 4.2 2010/08/02 16:36:55 alexk Exp $";


#############################################################################
##
#F  SmithNormalFormSQ( mat )
##
InstallGlobalFunction( SmithNormalFormSQ, function( M )
local r;
  Info(InfoWarning,1,"Obsolete function  `SmithNormalFormSQ',\n",
  "use `NormalFormIntMat' instead");
  r:=NormalFormIntMat(M,15);
  return rec(P:=r.rowtrans,Q:=r.coltrans,D:=r.normal,I:=r.coltrans^-1);
end );


#############################################################################
##
#F  DiagonalizeIntMatNormDriven(<mat>)  . . . . diagonalize an integer matrix
##
#T  Should this test for mutability? SL
##
InstallGlobalFunction( DiagonalizeIntMatNormDriven, function ( mat )
    local   nrrows,     # number of rows    (length of <mat>)
            nrcols,     # number of columns (length of <mat>[1])
            rownorms,   # norms of rows
            colnorms,   # norms of columns
            d,          # diagonal position
            pivk, pivl, # position of a pivot
            norm,       # product of row and column norms of the pivot
            clear,      # are the row and column cleared
            row,        # one row
            col,        # one column
            ent,        # one entry of matrix
            quo,        # quotient
            h,          # gap width in shell sort
            k, l,       # loop variables
            max, omax;  # maximal entry and overall maximal entry

    # give some information
    Info( InfoMatrix, 1, "DiagonalizeMat called" );
    omax := 0;

    # get the number of rows and columns
    nrrows := Length( mat );
    if nrrows <> 0  then
        nrcols := Length( mat[1] );
    else
        nrcols := 0;
    fi;
    rownorms := [];
    colnorms := [];

    # loop over the diagonal positions
    d := 1;
    Info( InfoMatrix, 2, "  divisors:" );

    while d <= nrrows and d <= nrcols  do

        # find the maximal entry
        Info( InfoMatrix, 3, "    d=", d );
        if 3 <= InfoLevel( InfoMatrix ) then
            max := 0;
            for k  in [ d .. nrrows ]  do
                for l  in [ d .. nrcols ]  do
                    ent := mat[k][l];
                    if   0 < ent and max <  ent  then
                        max :=  ent;
                    elif ent < 0 and max < -ent  then
                        max := -ent;
                    fi;
                od;
            od;
            Info( InfoMatrix, 3, "    max=", max );
            if omax < max  then omax := max;  fi;
        fi;

        # compute the Euclidean norms of the rows and columns
        for k  in [ d .. nrrows ]  do
            row := mat[k];
            rownorms[k] := row * row;
        od;
        for l  in [ d .. nrcols ]  do
            col := mat{[d..nrrows]}[l];
            colnorms[l] := col * col;
        od;
        Info( InfoMatrix, 3, "    n" );

        # push rows containing only zeroes down and forget about them
        for k  in [ nrrows, nrrows-1 .. d ]  do
            if k < nrrows and rownorms[k] = 0  then
                row         := mat[k];
                mat[k]      := mat[nrrows];
                mat[nrrows] := row;
                norm             := rownorms[k];
                rownorms[k]      := rownorms[nrrows];
                rownorms[nrrows] := norm;
            fi;
            if rownorms[nrrows] = 0  then
                nrrows := nrrows - 1;
            fi;
        od;

        # quit if there are no more nonzero entries
        if nrrows < d  then
            #N  1996/04/30 mschoene should 'break'
            Info( InfoMatrix, 3, "  overall maximal entry ", omax );
            Info( InfoMatrix, 1, "DiagonalizeMat returns" );
            return;
        fi;

        # push columns containing only zeroes right and forget about them
        for l  in [ nrcols, nrcols-1 .. d ]  do
            if l < nrcols and colnorms[l] = 0  then
                col                      := mat{[d..nrrows]}[l];
                mat{[d..nrrows]}[l]      := mat{[d..nrrows]}[nrcols];
                mat{[d..nrrows]}[nrcols] := col;
                norm             := colnorms[l];
                colnorms[l]      := colnorms[nrcols];
                colnorms[nrcols] := norm;
            fi;
            if colnorms[nrcols] = 0  then
                nrcols := nrcols - 1;
            fi;
        od;

        # sort the rows with respect to their norms
        h := 1;  while 9 * h + 4 < nrrows-(d-1)  do h := 3 * h + 1;  od;
        while 0 < h  do
            for l  in [ h+1 .. nrrows-(d-1) ]  do
                norm := rownorms[l+(d-1)];
                row := mat[l+(d-1)];
                k := l;
                while h+1 <= k  and norm < rownorms[k-h+(d-1)]  do
                    rownorms[k+(d-1)] := rownorms[k-h+(d-1)];
                    mat[k+(d-1)] := mat[k-h+(d-1)];
                    k := k - h;
                od;
                rownorms[k+(d-1)] := norm;
                mat[k+(d-1)] := row;
            od;
            h := QuoInt( h, 3 );
        od;

        # choose a pivot in the '<mat>{[<d>..]}{[<d>..]}' submatrix
        # the pivot must be the topmost nonzero entry in its column,
        # now that the rows are sorted with respect to their norm
        pivk := 0;  pivl := 0;
        norm := Maximum(rownorms) * Maximum(colnorms) + 1;
        for l  in [ d .. nrcols ]  do
            k := d;
            while mat[k][l] = 0  do
                k := k + 1;
            od;
            if rownorms[k] * colnorms[l] < norm  then
                pivk := k;  pivl := l;
                norm := rownorms[k] * colnorms[l];
            fi;
        od;
        Info( InfoMatrix, 3, "    p" );

        # move the pivot to the diagonal and make it positive
        if d <> pivk  then
            row       := mat[d];
            mat[d]    := mat[pivk];
            mat[pivk] := row;
        fi;
        if d <> pivl  then
            col                    := mat{[d..nrrows]}[d];
            mat{[d..nrrows]}[d]    := mat{[d..nrrows]}[pivl];
            mat{[d..nrrows]}[pivl] := col;
        fi;
        if mat[d][d] < 0  then
            MultRowVector(mat[d],-1);
        fi;

        # now perform row operations so that the entries in the
        # <d>-th column have absolute value at most pivot/2
        clear := true;
        row := mat[d];
        for k  in [ d+1 .. nrrows ]  do
            quo := BestQuoInt( mat[k][d], mat[d][d] );
            if quo = 1  then
                AddRowVector(mat[k], row, -1);
            elif quo = -1  then
                AddRowVector(mat[k], row);
            elif quo <> 0  then
                AddRowVector(mat[k], row, -quo);
            fi;
            clear := clear and mat[k][d] = 0;
        od;
        Info( InfoMatrix, 3, "    c" );

        # now perform column operations so that the entries in
        # the <d>-th row have absolute value at most pivot/2
        col := mat{[d..nrrows]}[d];
        for l  in [ d+1 .. nrcols ]  do
            quo := BestQuoInt( mat[d][l], mat[d][d] );
            if quo = 1  then
                mat{[d..nrrows]}[l] := mat{[d..nrrows]}[l] - col;
            elif quo = -1  then
                mat{[d..nrrows]}[l] := mat{[d..nrrows]}[l] + col;
            elif quo <> 0  then
                mat{[d..nrrows]}[l] := mat{[d..nrrows]}[l] - quo * col;
            fi;
            clear := clear and mat[d][l] = 0;
        od;
        Info( InfoMatrix, 3, "    r" );

        # repeat until the <d>-th row and column are totally cleared
        while not clear  do

            # compute the Euclidean norms of the rows and columns
            # that have a nonzero entry in the <d>-th column resp. row
            for k  in [ d .. nrrows ]  do
                if mat[k][d] <> 0  then
                    row := mat[k];
                    rownorms[k] := row * row;
                fi;
            od;
            for l  in [ d .. nrcols ]  do
                if mat[d][l] <> 0  then
                    col := mat{[d..nrrows]}[l];
                    colnorms[l] := col * col;
                fi;
            od;
            Info( InfoMatrix, 3, "    n" );

            # choose a pivot in the <d>-th row or <d>-th column
            pivk := 0;  pivl := 0;
            norm := Maximum(rownorms) * Maximum(colnorms) + 1;
            for l  in [ d+1 .. nrcols ]  do
                if 0 <> mat[d][l] and rownorms[d] * colnorms[l] < norm  then
                    pivk := d;  pivl := l;
                    norm := rownorms[d] * colnorms[l];
                fi;
            od;
            for k  in [ d+1 .. nrrows ]  do
                if 0 <> mat[k][d] and rownorms[k] * colnorms[d] < norm  then
                    pivk := k;  pivl := d;
                    norm := rownorms[k] * colnorms[d];
                fi;
            od;
            Info( InfoMatrix, 3, "    p" );

            # move the pivot to the diagonal and make it positive
            if d <> pivk  then
                row       := mat[d];
                mat[d]    := mat[pivk];
                mat[pivk] := row;
            fi;
            if d <> pivl  then
                col                    := mat{[d..nrrows]}[d];
                mat{[d..nrrows]}[d]    := mat{[d..nrrows]}[pivl];
                mat{[d..nrrows]}[pivl] := col;
            fi;
            if mat[d][d] < 0  then
                MultRowVector(mat[d],-1);
            fi;

            # now perform row operations so that the entries in the
            # <d>-th column have absolute value at most pivot/2
            clear := true;
            row := mat[d];
            for k  in [ d+1 .. nrrows ]  do
                quo := BestQuoInt( mat[k][d], mat[d][d] );
	        if quo = 1  then
                    AddRowVector(mat[k],row,-1);
                elif quo = -1  then
                    AddRowVector(mat[k],row);
                elif quo <> 0  then
                    AddRowVector(mat[k], row, -quo);
                fi;
                clear := clear and mat[k][d] = 0;
            od;
            Info( InfoMatrix, 3, "    c" );

            # now perform column operations so that the entries in
            # the <d>-th row have absolute value at most pivot/2
            col := mat{[d..nrrows]}[d];
            for l  in [ d+1.. nrcols ]  do
                quo := BestQuoInt( mat[d][l], mat[d][d] );
                if quo = 1  then
                    mat{[d..nrrows]}[l] := mat{[d..nrrows]}[l] - col;
                elif quo = -1  then
                    mat{[d..nrrows]}[l] := mat{[d..nrrows]}[l] + col;
                elif quo <> 0  then
                    mat{[d..nrrows]}[l] := mat{[d..nrrows]}[l] - quo * col;
                fi;
                clear := clear and mat[d][l] = 0;
            od;
            Info( InfoMatrix, 3, "    r" );

        od;

        # print the diagonal entry (for information only)
        Info( InfoMatrix, 3, "    div=" );
        Info( InfoMatrix, 2, "      ", mat[d][d] );

        # go on to the next diagonal position
        d := d + 1;

    od;

    # close with some more information
    Info( InfoMatrix, 3, "  overall maximal entry ", omax );
    Info( InfoMatrix, 1, "DiagonalizeMat returns" );
end );


#############################################################################
##
#M  CharacteristicPolynomial( <F>, <mat> )
#M  CharacteristicPolynomial( <field>, <matrix>, <indnum> )
##
##  The documentation of these usages of CharacteristicPolynomial was
##  ambiguous, leading to surprising results if mat was over F but
##  DefaultField (mat) properly contained F.
##  Now there is a four argument version which allows to specify the field
##  which specifies the linear action of mat, and another which specifies
##  the vector space which mat acts upon.
##
##  In the future, the versions above could be given a differnt meaning,
##  where the first argument simply specifies both fields in the case
##  when they are the same.
##
##  The following provides backwards compatibility with  {\GAP}~4.4. in the
##  cases where there is no ambiguity.
##
InstallOtherMethod( CharacteristicPolynomial,
     "supply indeterminate 1",
    [ IsField, IsMatrix ],
    function( F, mat )
        return CharacteristicPolynomial (F, mat, 1);
    end );

InstallOtherMethod( CharacteristicPolynomial,
    "check default field, print error if ambiguous",
    IsElmsCollsX,
    [ IsField, IsOrdinaryMatrix, IsPosInt ],
function( F, mat, inum )
        if IsSubset (F, DefaultFieldOfMatrix (mat)) then
            Info (InfoWarning, 1, "This usage of `CharacteristicPolynomial' is no longer supported. ",
                "Please specify two fields instead.");
            return CharacteristicPolynomial (F, F, mat, inum);
        else
            Error ("this usage of `CharacteristicPolynomial' is no longer supported, ",
                "please specify two fields instead.");
        fi;
end );


#############################################################################
##
#M  ShrinkCoeffs( <list> )
##
InstallMethod( ShrinkCoeffs,"call `ShrinkRowVector'",
    [ IsList and IsMutable ],
function( l1 )
    ShrinkRowVector(l1);
    return Length(l1);
end );

InstallOtherMethod( ShrinkCoeffs,"error if immutable",
    [ IsList ],
    L1_IMMUTABLE_ERROR);

#############################################################################
##
#M  ShrinkCoeffs( <vec> )
##
InstallMethod( ShrinkCoeffs, "8 bit vector",
        [IsMutable and IsRowVector and Is8BitVectorRep ],
        function(vec)
    local r;
    r := RIGHTMOST_NONZERO_VEC8BIT(vec);
    RESIZE_VEC8BIT(vec, r);
    return r;
end);

#############################################################################
##
#M  ShrinkCoeffs( <gf2vec> )  . . . . . . . . . . . . . . shrink a GF2 vector
##
InstallMethod( ShrinkCoeffs,
    "for GF2 vector",
    [ IsMutable and IsRowVector and IsGF2VectorRep ],
    SHRINKCOEFFS_GF2VEC );


#############################################################################
##
#F  ProductPol( <coeffs_f>, <coeffs_g> )  . . . .  product of two polynomials
##
InstallGlobalFunction( ProductPol, function( f, g )
    local  prod,  q,  m,  n,  i,  k;
    m := Length(f);  while 1 < m  and f[m] = 0  do m := m-1;  od;
    n := Length(g);  while 1 < n  and g[n] = 0  do n := n-1;  od;
#T other zero elements are not allowed?
    prod := [];
    for i  in [ 2 .. m+n ]  do
        q := 0;
        for k  in [ Maximum(1,i-n) .. Minimum(m,i-1) ]  do
            q := q + f[k] * g[i-k];
        od;
        prod[i-1] := q;
    od;
    return prod;
end );


#############################################################################
##
#E
