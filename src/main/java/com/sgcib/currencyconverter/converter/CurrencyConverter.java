package com.sgcib.currencyconverter.converter;

import com.google.common.collect.ImmutableMap;

import java.util.Map;

public class CurrencyConverter {
    public static final double EUROTOUSD_CONVERTRATE = 1.309d;
    public static final double USDTOEURO_CONVERTRATE = 0.7485d;
    private static Map<String,Double> currencies = ImmutableMap.of(
                            "EURUSD", EUROTOUSD_CONVERTRATE,
                            "USDEUR", USDTOEURO_CONVERTRATE);

    public Money convert(Double amount, String fromCurrency, String toCurrency) {
        if ( fromCurrency.equals(toCurrency) ) {
            return new Money(amount,toCurrency);
        }
        return new Money(amount * currencies.get(fromCurrency+toCurrency), toCurrency);
    }

}
