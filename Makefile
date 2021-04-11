CC = avr-gcc
LD = avr-gcc
OBJCOPY = avr-objcopy

AVRDUDE = avrdude
PART = m2560
PORT = usb
PROGRAMMER = avrispmkII

SRCDIR = src
OBJDIR = obj
BINDIR = bin

INCLUDES = -I./include -I/usr/lib/avr/include
CFLAGS = $(INCLUDES) -Os -DF_CPU=16000000UL -std=c11 -mmcu=atmega2560

LIBS = -L/usr/lib/avr/lib
LDFLAGS = $(LIBS) -mmcu=atmega2560

SRCS = $(wildcard $(SRCDIR)/*.c)
OBJS = $(SRCS:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

BIN = $(BINDIR)/main
HEX = $(BIN).hex

all: prepare $(HEX)

$(HEX): $(BIN)
	$(OBJCOPY) -O ihex -R .eeprom $< $@

$(BIN): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

$(OBJS): $(OBJDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

upload: $(HEX)
	$(AVRDUDE) -v -c $(PROGRAMMER) -p $(PART) -P $(PORT) -U flash:w:$<:i

prepare:
	-mkdir -pv $(OBJDIR)
	-mkdir -pv $(BINDIR)
clean:
	-rm -r $(BINDIR) $(OBJDIR)
