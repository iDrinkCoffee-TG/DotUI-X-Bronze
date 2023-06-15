.PHONY: all
.PHONY: clean

TARGET=mmenu

###########################################################

ifeq (,$(PLATFORM))
PLATFORM=$(UNION_PLATFORM)
endif
ifeq (,$(PLATFORM))
$(error please specify PLATFORM, eg. make PLATFORM=trimui)
endif
ifeq (,$(CROSS_COMPILE))
$(error missing CROSS_COMPILE for this toolchain)
endif
ifeq (,$(PREFIX))
$(error missing PREFIX for installation in toolchain)
endif

###########################################################

ifeq ($(DEBUG), 1)
	CFLAGS = -ggdb3 -Og -DDEBUG
else
	CFLAGS = -Os -DNDEBUG
	ifneq ($(PROFILE), 1)
		CFLAGS += -fdata-sections -ffunction-sections -Wl,--gc-sections -s
	endif
endif

CC = $(CROSS_COMPILE)gcc
SYSROOT := $(shell $(CC) --print-sysroot)
INCLUDEDIR = $(SYSROOT)/usr/include
LIBS = -lSDL -lSDL_image -lSDL_ttf -lz -lm -ldl -lrt

CFLAGS += -Wall -marm -march=armv7ve+simd -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard
CFLAGS += -flto -fipa-pta -fipa-ra -ftree-vectorize -ffast-math -funsafe-math-optimizations
CFLAGS += -fno-math-errno -fno-unwind-tables -fno-asynchronous-unwind-tables
CFLAGS += -I$(INCLUDEDIR) -I. -I../common -DPLATFORM_$(shell echo $(PLATFORM) | tr a-z A-Z) -std=gnu99
CFLAGS += -Wl,--no-as-needed
LDFLAGS = $(CFLAGS) $(LIBS)

all:
	$(CC) -c -fpic $(TARGET).c ../common/common.c $(CFLAGS)
	$(CC) -shared -o lib$(TARGET).so $(TARGET).o common.o $(LDFLAGS)
	cp $(TARGET).h $(PREFIX)/include
	cp lib$(TARGET).so $(PREFIX)/lib

clean:
	rm -f $(TARGET).o common.o
	rm -f lib$(TARGET).so
	rm -f $(PREFIX)/include/$(TARGET).h
	rm -f $(PREFIX)/lib/lib$(TARGET).so
