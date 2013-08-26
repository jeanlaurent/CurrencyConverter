package com.sgcib.currencyconverter.converter;

import com.google.common.collect.ImmutableMap;

import java.util.Map;

public class CurrencyConverter {
    private static Map<String,Double> currencies = ImmutableMap.of(
                            "EURUSD", 1.309d,
                            "USDEUR", 0.7485d);

    public Money convert(Double amount, String fromCurrency, String toCurrency) {
        if ( fromCurrency.equals(toCurrency) ) {
            return new Money(amount,toCurrency);
        }
        return new Money(amount * currencies.get(fromCurrency+toCurrency), toCurrency);
    }

}
