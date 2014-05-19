type file;

app (file _matrix, file _out, file _err) genmatrix (int _height, int _width){
  matrixgen _height _width @_matrix stdout=@_out stderr=@_err;
}

app (file _matrixc , file _out, file _err) matmul (int _heighta, int _widtha, int _widthb, file _matrixa, file _matrixb){
  mulmat _heighta _widtha _widthb @_matrixa @_matrixb @_matrixc stdout=@_out stderr=@_err;
}

app (file _matrixres, file _out, file _err) sum (int _size, file _matrixa, file _matrixb){
  sum _size @_matrixa @_matrixb @_matrixres stdout=@_out stderr=@_err;
}

app (file _matrixres, file _out, file _err) bulksum (int _size, file[] _matrixa, file[] _matrixb){
  bulksum _size @filenames(_matrixa) @filenames(_matrixb) @_matrixres stdout=@_out stderr=@_err;
}

app (file _scaleres, file _triadres,  file _out, file _err) scalentriad (int _size, file _scaletriadin, file _triadin, float _coeff){
  scalentriad _size @_scaletriadin @_triadin @_scaleres @_triadres _coeff stdout=@_out stderr=@_err;
}

int HA=2544;
int WA=3300; # generates 8M matrix
int WB=3300;
int mul=HA * WB;
float coeff[];
float coeffa=0.5;
float coeffb=0.8;

file mulin[]<simple_mapper; location="outdir", prefix="mulin.",suffix=".dat">;
file genmulinout[]<simple_mapper; location="outdir", prefix="genmulin.",suffix=".out">;
file genmulinerr[]<simple_mapper; location="errdir", prefix="genmulin.",suffix=".err">;

file sumin[]<simple_mapper; location="outdir", prefix="sumin.",suffix=".dat">;
file gensuminout[]<simple_mapper; location="outdir", prefix="gensumin.",suffix=".out">;
file gensuminerr[]<simple_mapper; location="errdir", prefix="gensumin.",suffix=".err">;

file mulres[]<simple_mapper; location="outdir", prefix="mulres.",suffix=".dat">;
file mulout[]<simple_mapper; location="outdir", prefix="mul.",suffix=".out">;
file mulerr[]<simple_mapper; location="errdir", prefix="mul.",suffix=".err">;

file sumres[]<simple_mapper; location="outdir", prefix="sumres.",suffix=".dat">;
file sumout[]<simple_mapper; location="outdir", prefix="sum.",suffix=".out">;
file sumerr[]<simple_mapper; location="errdir", prefix="sum.",suffix=".err">;

file bulksumres<"bulksumres.dat">;
file bulksumout<"bulksum.out">;
file bulksumerr<"bulksum.err">;

file scaleres[]<simple_mapper; location="outdir", prefix="scaleres.",suffix=".dat">;
file triadres[]<simple_mapper; location="outdir", prefix="triadres.",suffix=".dat">;
file scaleout[]<simple_mapper; location="outdir", prefix="scale.",suffix=".out">;
file scalerr[]<simple_mapper; location="errdir", prefix="scale.",suffix=".err">;

#generate 10 matrices for multiplication
foreach i in [0:9]{
 (mulin[i], genmulinout[i], genmulinerr[i]) = genmatrix (HA, WA);
}

#generate 100 matrices for summation
foreach j in [0:99]{
 (sumin[j], gensuminout[j], gensuminerr[j]) = genmatrix (WA, WB);
}

#pairwise multiplication
foreach k in [0:4]{
 (mulres[k], mulout[k], mulerr[k]) = matmul (HA, WA, WB, mulin[k], mulin[k+5]);
}

#pairwise summation
foreach l in [0:49]{
 (sumres[l], sumout[l], sumerr[l]) = sum (mul, sumin[l], sumin[l+50]);
}

#bulk summation
(bulksumres, bulksumout, bulksumerr) = bulksum (mul, sumres, mulres);

#scale and triad
foreach m in [1:100]{
 coeff[m]=m*0.0325;
 (scaleres[m], triadres[m], scaleout[m], scalerr[m]) = scalentriad (mul, bulksumres, sumres[0], coeff[m]);
}

