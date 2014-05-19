#!/bin/bash
#set -x

# 1. create two random matrices
#HA=100
#WA=200
#WB=300

#HA=2544
#WA=3300 # generates 8M matrix
#WB=3300

HA=3000
WA=4000
WB=4000

mA_file=mA.dat
mB_file=mB.dat
mC_file=mC.dat

echo "Gendata times"
time -p ./gendata/gendata $HA $WA $mA_file
time -p ./gendata/gendata $WA $WB $mB_file
echo

# 2. multiply the matrix: mC = mA * mB
echo "Matmul time"
time -p ./matmul/matrixMul $HA $WA $WB $mA_file $mB_file $mC_file
echo

# 3. scale the matrix: mD = coef * mC
mD_file=mD.dat
coef=0.5
mul=$(( $HA * $WB ))
echo "Scale time"
time -p ./stream_scale/scale $mul $mC_file $mD_file $coef
echo

# 4. sum two matrices: mE = mC + mD
mE_file=mE.dat
echo "Sum time"
time -p ./stream_sum/sum $mul $mC_file $mD_file $mE_file
echo

# 5. triad two matrices: mF = mC + coef * mE
coef=0.8
mF_file=mF.dat
echo "Triad time"
time -p ./stream_triad/triad $mul $mC_file $mE_file $mF_file $coef
echo

