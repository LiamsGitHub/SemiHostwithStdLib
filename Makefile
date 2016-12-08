######################################
# For STM32F100C8 on Kepler Eclipse using the ARM GNU toolchain
# Supports both the assembler and C startup code stubs
# Liam Goudge June 2014

# This project demonstrates semihosting using the nanolib and rdimon libraries

# Project Name
NAME=SemiHostwithStdLib

################### File Locations #####################
include filePath

# Compiler/Assembler/Linker Paths


CC=		$(PATH)arm-none-eabi-gcc
OD =	$(PATH)arm-none-eabi-objdump
NM =	$(PATH)arm-none-eabi-nm
AS =	$(PATH)arm-none-eabi-as
SZ =	$(PATH)arm-none-eabi-size

OBJDIR = Objects
INCLUDES = -I./

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
LINKER_SCRIPT = STM32F100C8v2.ld
LFLAGS=-mthumb -mcpu=cortex-m3 $(NO_SEMIHOST) -T $(LINKER_SCRIPT) # Use std libraries

# Other Stuff
ODFLAGS = -h --syms -S
REMOVE = rm -f

################### Build Steps #####################

all:
	@ echo "Compiling:"
	mkdir -p $(OBJDIR)

	$(CC) $(CFLAGS) -c semihost.c  -o $(OBJDIR)/semihost.o
	$(AS) $(ASFLAGS) -c startup.S -o $(OBJDIR)/startup.o
	$(CC) $(CFLAGS) -c semihost.S -o $(OBJDIR)/semihost_as.o

	@ echo " "	
	@ echo "Linking:"
	$(CC) $(LFLAGS) $(OBJDIR)/startup.o $(OBJDIR)/semihost_as.o $(OBJDIR)/semihost.o -o $(NAME).elf

	
	@ echo " "	
	@ echo "List file generation:"
	$(OD) $(ODFLAGS) $(NAME).elf > $(NAME).lst
	
	@ echo " "
	@ echo "Symbol table:"
	$(NM) -l $(NAME).elf
	
	@ echo " "
	@ echo "Executable size:"
	#$(SZ) --format=berkeley $(OBJDIR)/startup.o $(OBJDIR)/semihost_as.o $(OBJDIR)/semihost.o -o "$(NAME).elf"
	$(SZ) --format=berkeley $(NAME).elf
	
	@ echo " "
	@ echo "Cleaning up:"
	$(REMOVE) -r $(OBJDIR)
	

	
	

