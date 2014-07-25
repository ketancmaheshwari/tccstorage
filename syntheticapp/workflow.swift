type file;

app (file _matrix, file _out, file _err) genmatrix (int _height, int _width){
  matrixgen _height _width @_matrix stdout=@_out stderr=@_err;
}

app (file _matrixc , file _out, file _err) matmul (int _heighta, int _widtha, int _widthb, file _matrixa, file _matrixb){
  mulmat _heighta _widtha _widthb @_matrixa @_matrixb @_matrixc stdout=@_out stderr=@_err;
}

app (file _matrixres, file _out, file _err) scale (int _size, file _matrix, float _coeff){
  scale _size @_matrix @_matrixres _coeff stdout=@_out stderr=@_err;
}

app (file _matrixres, file _out, file _err) sum (int _size, file _matrixa, file _matrixb){
  sum _size @_matrixa @_matrixb @_matrixres stdout=@_out stderr=@_err;
}

app (file _matrixres, file _out, file _err) triad (int _size, file _matrixa, file _matrixb, float _coeff){
  triad _size @_matrixa @_matrixb @_matrixres _coeff stdout=@_out stderr=@_err;
}

int HA=2544;
int WA=3300; # generates 8M matrix
int WB=3300;

int mul=HA * WB;
float coeffa=0.5;
float coeffb=0.8;

file mA_file[]<simple_mapper; location="outdir", prefix="ma.",suffix=".out">;
file mB_file[]<simple_mapper; location="outdir", prefix="mb.",suffix=".out">;
file mC_file[]<simple_mapper; location="outdir", prefix="mc.",suffix=".out">;

file genout1[]<simple_mapper; location="outdir", prefix="gen1.",suffix=".out">;
file genout2[]<simple_mapper; location="outdir", prefix="gen2.",suffix=".out">;

file generr1[]<simple_mapper; location="outdir", prefix="gen1.",suffix=".err">;
file generr2[]<simple_mapper; location="outdir", prefix="gen2.",suffix=".err">;

file mulout[]<simple_mapper; location="outdir", prefix="mul.",suffix=".out">;
file mulerr[]<simple_mapper; location="outdir", prefix="mul.",suffix=".err">;

file mD_file[]<simple_mapper; location="outdir", prefix="md.",suffix=".out">;
file scaleout[]<simple_mapper; location="outdir", prefix="scale.",suffix=".out">;
file scaleerr[]<simple_mapper; location="outdir", prefix="scale.",suffix=".err">;

file mE_file[]<simple_mapper; location="outdir", prefix="me.",suffix=".out">;
file sumout[]<simple_mapper; location="outdir", prefix="sum.",suffix=".out">;
file sumerr[]<simple_mapper; location="outdir", prefix="sum.",suffix=".err">;

file mF_file[]<simple_mapper; location="outdir", prefix="mf.",suffix=".out">;
file triadout[]<simple_mapper; location="outdir", prefix="triad.",suffix=".out">;
file triaderr[]<simple_mapper; location="outdir", prefix="triad.",suffix=".err">;

foreach i in [0:1]{
   # 1. create two random matrices
   (mA_file[i], genout1[i], generr1[i])=genmatrix(HA, WA);
   (mB_file[i], genout2[i], generr2[i])=genmatrix(WA, WB);
   
   # 2. multiply the matrix: mC = mA * mB
   (mC_file[i], mulout[i], mulerr[i]) = matmul (HA, WA, WB, mA_file[i], mB_file[i]);
   
   # 3. scale the matrix: mD = coef * mC   
   (mD_file[i], scaleout[i], scaleerr[i]) = scale(mul, mC_file[i], coeffa);
   
   # 4. sum two matrices: mE = mC + mD
   (mE_file[i], sumout[i], sumerr[i])=sum(mul, mC_file[i], mD_file[i]);
   
   # 5. triad two matrices: mF = mC + coef * mE
   (mF_file[i], triadout[i], triaderr[i])=triad(mul, mC_file[i], mE_file[i], coeffb);
}

