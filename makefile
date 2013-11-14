EXECUTABLE= main.elf
TARGET = main.hex

CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
AS = arm-none-eabi-as
CP = arm-none-eabi-objcopy
OD = arm-none-eabi-objdump


DEFINES = -DSTM32F4XX -DUSE_STDPERIPH_DRIVER -DSTM32F40_41xxx
MCU = cortex-m4 

MCFLAGS = -mcpu=$(MCU) -mthumb -mlittle-endian -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb-interwork -fsingle-precision-constant

INCLUDES = -I./Libraries/CMSIS/Device/ST/STM32F4xx/Include \
	   -I./Libraries/CMSIS/Include \
	   -I./Libraries/CMSIS/RTOS \
	   -I./Libraries/STM32F4xx_StdPeriph_Driver/inc \
	   -I./Utilities/STM32F4-Discovery/ \
	   -I./Libraries/STM32_USB_Device_Library/Core/inc/ \
	   -I./Libraries/STM32_USB_Device_Library/Class/hid/inc/ \
	   -I./Libraries/STM32_USB_OTG_Driver/inc/ \
	   -I.

OPTIMIZE = -Os

LINK = stm32_flash.ld

LINKER = -Wl,-T,stm32_flash.ld
	   
CFLAGS = $(INCLUDES) $(MCFLAGS) $(DEFINES) $(INCLUDES) $(OPTIMIZE) $(LINKER)

STARTUP = startup_stm32f40xx.s

SOURCE = main.c \
	 selftest.c \
	 system_stm32f4xx.c \
	 stm32f4xx_it.c \
	 system_stm32f4xx.c \
	 usb_bsp.c \
	 usbd_desc.c \
	 usbd_usr.c \
	 ./Utilities/STM32F4-Discovery/stm32f4_discovery.c \
	 ./Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_rcc.c \
	 ./Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_gpio.c \
	 ./Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_tim.c \
	 ./Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_spi.c \
	 ./Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_exti.c \
	 ./Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_adc.c \
	 ./Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_syscfg.c \
	 ./Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_dma.c \
	 ./Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_dac.c \
	 ./Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_i2c.c \
	 ./Libraries/STM32F4xx_StdPeriph_Driver/src/stm32f4xx_flash.c \
	 ./Libraries/STM32F4xx_StdPeriph_Driver/src/misc.c \
	 ./Libraries/STM32_USB_Device_Library/Core/src/usbd_core.c \
	 ./Libraries/STM32_USB_Device_Library/Core/src/usbd_ioreq.c \
	 ./Libraries/STM32_USB_Device_Library/Core/src/usbd_req.c \
	 ./Libraries/STM32_USB_OTG_Driver/src/usb_core.c \
	 ./Libraries/STM32_USB_OTG_Driver/src/usb_dcd.c \
	 ./Libraries/STM32_USB_OTG_Driver/src/usb_dcd_int.c \
	 ./Libraries/STM32_USB_Device_Library/Class/hid/src/usbd_hid_core.c \
	 ./Utilities/STM32F4-Discovery/stm32f4_discovery_audio_codec.c \
	 ./Utilities/STM32F4-Discovery/stm32f4_discovery_lis302dl.c

$(TARGET) : $(EXECUTABLE) 
	
	$(CP) -O ihex $^ $@

$(EXECUTABLE) :  $(SOURCE) $(STARTUP)

	$(CC)  $(CFLAGS) $^ -g -lm -lc -lnosys -o $@



