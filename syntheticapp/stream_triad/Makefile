CPP_BIN = g++

BINARY	:= triad

TARGET_DIR = .

MACROS = -DGPU_CLOCK=$(GPU_CLOCK) -DCPU_CLOCK=$(CPU_CLOCK)

OPT = 2
MODE = RELEASE
ASSEMBLY = no

# ------------------

ifeq ($(PROF), yes)
	PROF_FLAGS += -DPROF
endif

# determine flags according to the mode
ifeq ($(MODE), DEBUG)
	CFLAGS = -g -O$(OPT) $(PROF_FLAGS)
endif
ifeq ($(MODE), RELEASE)
	CFLAGS = -O$(OPT) $(PROF_FLAGS)
endif

CPP_SRC	= $(wildcard *.cpp)

CC		= $(C_BIN)
CPP		= $(CPP_BIN)

ifeq ($(ASSEMBLY), yes)
	OBJ	= $(F_SRC:.f=.s) $(CPP_SRC:.cpp=.s) $(C_SRC:.c=.s)
	#OBJ	= $(patsubst %.cpp,$(TARGET_DIR)/%.s,$(wildcard $(CPP_SRC)))
endif
ifeq ($(ASSEMBLY), no)
	OBJ	= $(F_SRC:.f=.o) $(CPP_SRC:.cpp=.o) $(C_SRC:.c=.o)
endif

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

ifneq ($(TARGET_DIR),.)
	mv -f $(patsubst %.cpp, %.o, $(wildcard $(CPP_SRC))) $(TARGET_DIR)/
endif
	$(CPP) $(patsubst %.cpp,$(TARGET_DIR)/%.o,$(wildcard $(CPP_SRC))) $(TIMER_OBJ) $(CFLAGS)  ../sysdetails/sysdetails.o -o $(TARGET_DIR)/$(BINARY)

clean:
	rm -f $(BINARY) *.o *.s

asm: $(OBJ) $(TIMER_OBJ)
	#python ../commons/asm.py xl2gcc $(patsubst %.cpp, %.s, $(wildcard $(CPP_SRC)))
ifneq ($(TARGET_DIR),.)
	mv -f $(patsubst %.cpp, %.s, $(wildcard $(CPP_SRC))) $(TARGET_DIR)/
endif
	#$(CPP) $(patsubst %.cpp,$(TARGET_DIR)/%.s,$(wildcard $(CPP_SRC))) $(TIMER_OBJ) $(CFLAGS) -o $(TARGET_DIR)/$(BINARY)
	$(CPP) $(patsubst %.cpp,$(TARGET_DIR)/%.s,$(wildcard $(CPP_SRC))) $(TIMER_OBJ) $(CFLAGS) -o $(TARGET_DIR)/$(BINARY)

$(TIMER_OBJ):
	make -C $(TIMER_DIR)

ifeq ($(CLUSTER), Surveyor)
  QUEUE_CMD = cqsub -t 60 -n 1
else
  ifeq ($(CLUSTER), Mira)
    QUEUE_CMD = qsub -A perfmodel -t 60 -n 1 --env VPROF_PROFILE=yes
  endif
endif
qsub: $(BINARY)
	$(QUEUE_CMD) $(BINARY) 1000 1000 1000

run: $(BINARY)
	./$(BINARY)

PIN_DIR	= /home/jmeng/mcssvn/tools/pin-2.8-39028-gcc.3.4.6-ia32_intel64-linux/
PIN_RTNINSTCOUNT_DIR = $(PIN_DIR)/source/tools/RtnsInstCount/

pin:
	$(PIN_DIR)/pin -t $(PIN_RTNINSTCOUNT_DIR)/obj-intel64/MyPinTool.so -- ./$(BINARY)
