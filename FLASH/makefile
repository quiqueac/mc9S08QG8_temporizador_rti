################################################################################
# Automatically-generated file. Do not edit!
################################################################################

#Progress monitor hint: 1
first : all
-include ../makefile.init

# This file contains definitions of environment variables used in the makefiles and .args files if exist.
-include makefile.local

RM := "$(GNU_Make_Install_DirEnv)/rm" -f

# All of the sources participating in the build are defined here
-include sources.mk
-include subdir.mk
-include Sources/subdir.mk
-include Project_Settings/Linker_Files/subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(ASM_DEPS)),)
-include $(ASM_DEPS)
endif
ifneq ($(strip $(ASM_UPPER_DEPS)),)
-include $(ASM_UPPER_DEPS)
endif
ifneq ($(strip $(S_DEPS)),)
-include $(S_DEPS)
endif
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
OBJS += \
default.lst \
mc9S08QG8_temporizador_rti.obj \

OBJS_QUOTED += \
"default.lst" \
"mc9S08QG8_temporizador_rti.obj" \

OBJS_OS_FORMAT += \
default.lst \
mc9S08QG8_temporizador_rti.obj \

EXECUTABLES += \
mc9S08QG8_temporizador_rti.obj \

EXECUTABLES_QUOTED += \
"mc9S08QG8_temporizador_rti.obj" \

EXECUTABLES_OS_FORMAT += \
mc9S08QG8_temporizador_rti.obj \

BURNER_OUTPUT_OUTPUTS += \
mc9S08QG8_temporizador_rti.obj.s19 \

BURNER_OUTPUT_OUTPUTS_QUOTED += \
"mc9S08QG8_temporizador_rti.obj.s19" \

BURNER_OUTPUT_OUTPUTS_OS_FORMAT += \
mc9S08QG8_temporizador_rti.obj.s19 \


# All Target
call-burner := 0
ifneq ($(strip $(EXECUTABLES)),)
ifneq ($(strip $(BBL_SRCS_QUOTED)),)
call-burner := 1
endif
endif
ifeq ($(call-burner),1)
all: mc9S08QG8_temporizador_rti.obj mc9S08QG8_temporizador_rti.obj.s19
else
all: mc9S08QG8_temporizador_rti.obj
endif

# Tool invocations
mc9S08QG8_temporizador_rti.obj: $(ASM_SRCS)
	@echo 'Building target: $@'
	@echo 'Executing target #2 $@'
	@echo 'Invoking: HCS08 Assembler'
	"$(HC08ToolsEnv)/ahc08" -Objn"mc9S08QG8_temporizador_rti.obj" -ArgFile"mc9S08QG8_temporizador_rti.args" $(ASM_SRCS_QUOTED) $(ASM_SRCS_QUOTED)
	@echo 'Finished building target: $@'
	@echo ' '

mc9S08QG8_temporizador_rti.obj.s19: $(BBL_SRCS) $(EXECUTABLES)
	@echo 'Executing target #3 $@'
	@echo 'Invoking: S08 Burner'
	"$(HC08ToolsEnv)/burner" -ArgFile"mc9S08QG8_temporizador_rti.obj.args" -f="$<" -env"ABS_FILE=$(strip $(EXECUTABLES_OS_FORMAT))"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(S_DEPS_QUOTED) "./*/*.d"  $(BURNER_OUTPUT_OUTPUTS_QUOTED) $(ASM_UPPER_DEPS_QUOTED) "./*/*.obj"  $(EXECUTABLES_QUOTED) $(S_UPPER_DEPS_QUOTED) $(ProjDirPath)/FLASH/mc9S08QG8_temporizador_rti.obj $(ProjDirPath)/FLASH/mc9S08QG8_temporizador_rti.args $(ProjDirPath)/FLASH/mc9S08QG8_temporizador_rti.obj.args $(ProjDirPath)/FLASH/mc9S08QG8_temporizador_rti.obj.s19 $(ProjDirPath)/FLASH/mc9S08QG8_temporizador_rti.sx
	-@echo ' '

.PHONY: all clean dependents explicit-dependencies warning-messages
.SECONDARY:

-include ../makefile.targets

explicit-dependencies: 

warning-messages: 

