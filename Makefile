AVRDUDE_PATH = avrdude

SRC_DIR = ./src
INCLUDE_DIRS = -I./include -I/usr/lib/avr/include

CC = avr-gcc
OBJCOPY = avr-objcopy

AVRDUDE = $(AVRDUDE_PATH)
PORT = usb
PROGRAMMER = avrispmkII
PART = m2560

CFLAGS = -Os -DF_CPU=16000000UL $(INCLUDE_DIRS) -std=c11 -mmcu=atmega2560
LDFLAGS = -L/usr/lib/avr/lib -mmcu=atmega2560
OBJECTS = $(TARGET).o

TARGET = main

all: clean upload

$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex -R .eeprom $< $@

$(TARGET).elf: $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

upload: $(TARGET).hex
	$(AVRDUDE) -v -c $(PROGRAMMER) -p $(PART) -P $(PORT) -U flash:w:$<:i

clean:
	-rm -f $(TARGET).hex $(TARGET).elf $(OBJECTS)
