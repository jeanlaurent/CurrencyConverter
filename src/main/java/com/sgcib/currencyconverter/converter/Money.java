package com.sgcib.currencyconverter.converter;

import org.codehaus.jackson.annotate.JsonProperty;

public class Money {
    @JsonProperty public double quantity;
    @JsonProperty public String currency;

    public Money() {
    }

    public Money( double quantity, String currency) {
        this.quantity = quantity;
        this.currency = currency;
    }

    @Override
    public String toString() {
        return "Money{" +
            "quantity=" + quantity +
            ", currency='" + currency + '\'' +
            '}';
    }

}
