ifeq (,$(CROSS_COMPILE))
$(error missing CROSS_COMPILE for this toolchain)
endif

TARGET=mamedb

.PHONY: build
.PHONY: clean

CC = $(CROSS_COMPILE)gcc

CFLAGS  = -Ofast -Wall -marm -march=armv7ve+simd -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard
CFLAGS += -ffunction-sections -fdata-sections -fno-unwind-tables -fno-asynchronous-unwind-tables
CFLAGS += -fno-stack-protector -fno-ident -fomit-frame-pointer -fno-math-errno -ffast-math
CFLAGS += -falign-functions=1 -falign-jumps=1 -falign-loops=1 -falign-labels=1 -fpack-struct=1

LDFLAGS = -Wl,--gc-sections -Wl,-s

build:
	$(CC) -c -fPIC "$(TARGET).c" -Wl,--no-as-needed $(LDFLAGS)
	$(CC) -shared -o "lib$(TARGET).so" "$(TARGET).o" $(LDFLAGS)

clean:
	rm -f *.o
	rm -f "lib$(TARGET).so"
