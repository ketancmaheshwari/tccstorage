CPP_BIN = g++

BINARY	:= gendata

TARGET_DIR = .

MACROS = -DGPU_CLOCK=$(GPU_CLOCK) -DCPU_CLOCK=$(CPU_CLOCK)

OPT = 2
MODE = RELEASE

# ------------------

# determine flags according to the mode

CPP_SRC	= $(wildcard *.cpp)

CC		= $(C_BIN)
CPP		= $(CPP_BIN)

OBJ	= $(F_SRC:.f=.o) $(CPP_SRC:.cpp=.o) $(C_SRC:.c=.o)

.c.o :
	$(CC) $(CFLAGS) $< -c

.cpp.o :
	$(CPP) $(CFLAGS) $< -c

.f.o :
	$(FC) $(CFLAGS) $< -c

.c.s :
	$(CC) -O$(OPT) $< -S

.cpp.s :
	$(CPP) -O$(OPT) $< -S

.f.s :
	$(FC) -O$(OPT) $< -S

%.o : %.cu
	$(CUDA_NVCC) $(CUDA_FLAGS) -I $(CUDA_INC_DIR) -L $(CUDA_LIB_DIR) $< -c

all: $(BINARY)

$(BINARY): $(OBJ) $(TIMER_OBJ)
	$(CPP) -o $@ $^ $(libs) ../sysdetails/sysdetails.o
	$(CPP) $(patsubst %.cpp,$(TARGET_DIR)/%.o,$(wildcard $(CPP_SRC))) $(TIMER_OBJ) $(CFLAGS) ../sysdetails/sysdetails.o -o $(TARGET_DIR)/$(BINARY)

clean:
	rm -f $(BINARY) *.o *.s

run: $(BINARY)
	./$(BINARY)

