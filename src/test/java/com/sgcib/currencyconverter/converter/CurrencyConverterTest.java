package com.sgcib.currencyconverter.converter;

import org.junit.Before;
import org.junit.Test;

import static org.fest.assertions.Assertions.assertThat;


public class CurrencyConverterTest {

    private CurrencyConverter currencyConverter;

    @Before
    public void init(){
        currencyConverter = new CurrencyConverter();
    }

    @Test
    public void should_convert_from_USD_to_EUR() {
        assertThat(currencyConverter.convert(10d, "USD", "EUR")).isEqualTo(new Money(7.485d,"EUR"));
    }

    @Test
    public void should_convert_from_EUR_to_USD() {
        assertThat(currencyConverter.convert(10d, "EUR", "USD")).isEqualTo(new Money(13.09d,"USD"));
    }

    @Test
    public void should_convert_from_EUR_to_EUR() {
        assertThat(currencyConverter.convert(10d, "EUR", "EUR")).isEqualTo(new Money(10d,"EUR"));
    }

    @Test
    public void should_convert_from_USD_to_USD() {
        assertThat(currencyConverter.convert(10d, "USD", "USD")).isEqualTo(new Money(10d,"USD"));
    }

}
