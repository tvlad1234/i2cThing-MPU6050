##########################################################################################################################
# File automatically-generated by tool: [projectgenerator] version: [3.16.0] date: [Thu Apr 14 11:07:50 EEST 2022] 
# Modified for use with i2c thing
##########################################################################################################################

# ------------------------------------------------
# Generic Makefile (based on gcc)
#
# ChangeLog :
#	2017-02-10 - Several enhancements + project update mode
#   2015-07-22 - first version
# ------------------------------------------------

# drivers
APPDRIV = MPU6050-Cube

#other subdirectories
SUBDIRS = App

######################################
# target
######################################
TARGET = thing


######################################
# building variables
######################################
# debug build?
DEBUG = 1
# optimization
OPT = -Os


#######################################
# paths
#######################################
# Build path
BUILD_DIR = build

######################################
# source
######################################


# C includes
C_INCLUDES =  \
-I$(foreach fd, $(APPDRIV), AppDrivers/$(fd)/Inc) \
-I$(foreach fd, $(SUBDIRS), $(fd)/Inc) \
-IThingDriver/Core/Inc \
-IThingDriver/Drivers/OLED/Inc \
-IThingDriver/Drivers/STM32G0xx_HAL_Driver/Inc \
-IThingDriver/Drivers/STM32G0xx_HAL_Driver/Inc/Legacy \
-IThingDriver/Drivers/CMSIS/Device/ST/STM32G0xx/Include \
-IThingDriver/Drivers/CMSIS/Include

# C sources
C_SOURCES =  \
$(wildcard *.c $(foreach fd, $(APPDRIV), AppDrivers/$(fd)/Src/*.c)) \
$(wildcard *.c $(foreach fd, $(SUBDIRS), $(fd)/Src/*.c)) \
ThingDriver/Core/Src/main.c \
ThingDriver/Core/Src/stm32g0xx_it.c \
ThingDriver/Core/Src/stm32g0xx_hal_msp.c \
ThingDriver/Drivers/OLED/Src/ssd1306.c \
ThingDriver/Drivers/OLED/Src/gfx.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal_i2c.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal_i2c_ex.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal_rcc.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal_rcc_ex.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_ll_rcc.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal_flash.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal_flash_ex.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal_gpio.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal_dma.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal_dma_ex.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_ll_dma.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal_pwr.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal_pwr_ex.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal_cortex.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal_exti.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal_tim.c \
ThingDriver/Drivers/STM32G0xx_HAL_Driver/Src/stm32g0xx_hal_tim_ex.c \
ThingDriver/Core/Src/system_stm32g0xx.c \
ThingDriver/Core/Src/syscalls.c \
ThingDriver/Core/Src/sysmem.c 


# ASM sources
ASM_SOURCES =  \
ThingDriver/startup_stm32g031xx.s


#######################################
# binaries
#######################################
PREFIX = arm-none-eabi-
# The gcc compiler bin path can be either defined in make command via GCC_PATH variable (> make GCC_PATH=xxx)
# either it can be added to the PATH environment variable.
ifdef GCC_PATH
CC = $(GCC_PATH)/$(PREFIX)gcc
AS = $(GCC_PATH)/$(PREFIX)gcc -x assembler-with-cpp
CP = $(GCC_PATH)/$(PREFIX)objcopy
SZ = $(GCC_PATH)/$(PREFIX)size
else
CC = $(PREFIX)gcc
AS = $(PREFIX)gcc -x assembler-with-cpp
CP = $(PREFIX)objcopy
SZ = $(PREFIX)size
endif
HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S
 
#######################################
# CFLAGS
#######################################
# cpu
CPU = -mcpu=cortex-m0plus

# fpu
# NONE for Cortex-M0/M0+/M3

# float-abi


# mcu
MCU = $(CPU) -mthumb $(FPU) $(FLOAT-ABI)

# macros for gcc
# AS defines
AS_DEFS = 

# C defines
C_DEFS =  \
-DUSE_HAL_DRIVER \
-DSTM32G031xx


# AS includes
AS_INCLUDES = 

# compile gcc flags
ASFLAGS = $(MCU) $(AS_DEFS) $(AS_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

CFLAGS += $(MCU) $(C_DEFS) $(C_INCLUDES) $(OPT) -Wall -fdata-sections -ffunction-sections

ifeq ($(DEBUG), 1)
CFLAGS += -g -gdwarf-2
endif


# Generate dependency information
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)"


#######################################
# LDFLAGS
#######################################
# link script
LDSCRIPT = ThingDriver/STM32G031J6Mx_FLASH.ld

# libraries
LIBS = -lc -lm -lnosys 
LIBDIR = 
LDFLAGS = $(MCU) -specs=nano.specs -T$(LDSCRIPT) $(LIBDIR) $(LIBS) -Wl,-Map=$(BUILD_DIR)/$(TARGET).map,--cref -Wl,--gc-sections 

# default action: build all
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin


#######################################
# build the application
#######################################
# list of objects
OBJECTS = $(addprefix $(BUILD_DIR)/,$(notdir $(C_SOURCES:.c=.o)))
vpath %.c $(sort $(dir $(C_SOURCES)))
# list of ASM program objects
OBJECTS += $(addprefix $(BUILD_DIR)/,$(notdir $(ASM_SOURCES:.s=.o)))
vpath %.s $(sort $(dir $(ASM_SOURCES)))

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR) 
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX) $< $@
	
$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN) $< $@	
	
$(BUILD_DIR):
	mkdir $@		

#######################################
# clean up
#######################################
clean:
	-rm -fR $(BUILD_DIR)
  
#######################################
# dependencies
#######################################
-include $(wildcard $(BUILD_DIR)/*.d)

# *** EOF ***
