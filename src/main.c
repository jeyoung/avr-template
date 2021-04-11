#include <avr/io.h>
#include <util/delay.h>

#define LED_PIN        PB7
#define BLINK_INTERVAL 2000

void delay_ms(uint16_t ms);
void setup();
void loop();

int main(void)
{
    setup();
    while (1) {
	loop();
    }
    return 0;
}

void setup()
{
    DDRB |= (1 << LED_PIN);
}

void loop()
{
    PORTB ^= (1 << LED_PIN);
    delay_ms(BLINK_INTERVAL);
}

void delay_ms(uint16_t ms)
{
    while (--ms > 0) {
        _delay_ms(1);
    }
}
