package com.sgcib.currencyconverter.converter;

import org.codehaus.jackson.annotate.JsonCreator;
import org.codehaus.jackson.annotate.JsonProperty;

public class Money {
    private float quantity;
    private String currency;

    @JsonCreator
    public Money(@JsonProperty("quantity") float quantity,@JsonProperty("currency") String currency) {
        this.quantity = quantity;
        this.currency = currency;
    }

    public float getQuantity() {
        return quantity;
    }

    public String getCurrency() {
        return currency;
    }

    @Override
    public String toString() {
        return "Money{" +
            "quantity=" + quantity +
            ", currency='" + currency + '\'' +
            '}';
    }
}
