######################################
# For STM32F100C8 on Kepler Eclipse using the ARM GNU toolchain
# Supports both the assembler and C startup code stubs
# Liam Goudge June 2014

# This project demonstrates semihosting using the nanolib and rdimon libraries

################### Project name and sources #####################
include filePath

NAME=SemiHostwithStdLib

C_SOURCES = semihost_std.c 	# Enter list of all the C source files here
S_SOURCES = $(FOUNDATION)/startup_std.S  $(FOUNDATION)/semihost_std.S	# Enter list of all the assembler source files here


OBJECTS = $(C_SOURCES:.c=.o) $(S_SOURCES:.S=.o)
OBJDIR = Objects2
INCLUDES = -I./

################### Tool Location #####################
# Compiler/Assembler/Linker Paths

CC=		$(TOOLS)arm-none-eabi-gcc
OD =	$(TOOLS)arm-none-eabi-objdump
NM =	$(TOOLS)arm-none-eabi-nm
AS =	$(TOOLS)arm-none-eabi-as
SZ =	$(TOOLS)arm-none-eabi-size

################### Libraries #####################
# Library settings
USE_NANO=--specs=nano.specs --specs=rdimon.specs
USE_SEMIHOST=--specs=rdimon.specs -lc -lc -lrdimon
NO_SEMIHOST = -lgcc -lc -lm

################### GNU Flags #####################
# Compiler Flags
CFLAGS = -mcpu=cortex-m3 -mthumb -I./ -Wall -g

# Assembler Flags
ASFLAGS = -mcpu=cortex-m3 -mthumb

# Linker Flags 
LINKER_SCRIPT = $(FOUNDATION)/STM32F100C8v2_std.ld
LDFLAGS=-mthumb -mcpu=cortex-m3 $(NO_SEMIHOST) -T $(LINKER_SCRIPT) # Use std libraries

# Other Stuff
ODFLAGS = -h --syms -S
REMOVE = rm -f

################### Build Steps #####################

all: $(NAME).elf

$(NAME).elf: $(OBJECTS)
	@ echo "Link:"
	$(CC) $(LDFLAGS)  $^ -o $@
	/bin/rm -f *.o
	$(OD) $(ODFLAGS) $@ > $(NAME).lst
	$(SZ) --format=berkeley $@
	
.S.o:
	@ echo "asm:"
	$(CC) $(ASFLAGS) -o $@ -c $<

.c.o:
	@ echo "c:"
	$(CC) $(CFLAGS) -o $@ -c $<

clean:
	@ echo " "
	@ echo "Clean up"
	/bin/rm -f *.o *.elf *.lst	

