import os

def execCmd(cmd):
    print cmd
    os.system(cmd)

cur_dir = os.path.abspath(os.getcwd())

# 0. compile the programs
os.chdir(os.path.join(cur_dir, "gendata"))
os.system('make clean')
os.system('make')
os.chdir(os.path.join(cur_dir, "matmul"))
os.system('make clean')
os.system('make')
os.chdir(os.path.join(cur_dir, "stream_scale"))
os.system('make clean')
os.system('make')
os.chdir(os.path.join(cur_dir, "stream_sum"))
os.system('make clean')
os.system('make')
os.chdir(os.path.join(cur_dir, "stream_triad"))
os.system('make clean')
os.system('make')
os.chdir(cur_dir)

# 1. create two random matrices
HA = 200
WA = 200
WB = 400

mA_file = "mA.dat"
mB_file = "mB.dat"
mC_file = "mC.dat"
execCmd("%s %d %d %s" % (os.path.join(cur_dir, 'gendata', 'gendata'), HA, WA, mA_file))
execCmd("%s %d %d %s" % (os.path.join(cur_dir, 'gendata', 'gendata'), WA, WB, mB_file))

# 2. multiply the matrix: mC = mA * mB
execCmd("%s %d %d %d %s %s %s" % (os.path.join(cur_dir, 'matmul', 'matrixMul'), HA, WA, WB, mA_file, mB_file, mC_file))

# 3. scale the matrix: mD = coef * mC
mD_file = "mD.dat"
coef = 0.5
execCmd("%s %d %s %s %f" % (os.path.join(cur_dir, 'stream_scale', 'scale'), HA*WB, mC_file, mD_file, coef))

# 4. sum two matrices: mE = mC + mD
mE_file = "mE.dat"
execCmd("%s %d %s %s %s" % (os.path.join(cur_dir, 'stream_sum', 'sum'), HA*WB, mC_file, mD_file, mE_file))

# 4. triad two matrices: mF = mC + coef * mE
coef = 0.6
mF_file = "mF.dat"
execCmd("%s %d %s %s %s %f" % (os.path.join(cur_dir, 'stream_triad', 'triad'), HA*WB, mC_file, mE_file, mF_file, coef))

