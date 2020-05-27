#include <avr/io.h>
#include <util/delay.h>

void
delay_ms(uint16_t);

int
main(void)
{
    DDRB |= (1 << PB7);
    while (1)
    {
        PORTB ^= (1 << PB7);
        delay_ms(2000);
    }
}

void
delay_ms(uint16_t ms)
{
    while (--ms > 0)
        _delay_ms(1);
}
