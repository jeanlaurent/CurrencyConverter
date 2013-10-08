package com.sgcib.currencyconverter.converter;

import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

@Path("/convert")
public class ConverterResource {
    private final CurrencyConverter currencyConverter;

    public ConverterResource() {
        this.currencyConverter = new CurrencyConverter();
    }

    @GET
    @Produces("application/json;charset=UTF-8")
    @Path("/{fromCurrency}/{toCurrency}")
    public Money convert(@DefaultValue("0") @QueryParam("amount") double amount,
                         @PathParam("fromCurrency") String fromCurrency,
                         @PathParam("toCurrency") String toCurrency) {
        return currencyConverter.convert(amount, fromCurrency,toCurrency);
    }

}
