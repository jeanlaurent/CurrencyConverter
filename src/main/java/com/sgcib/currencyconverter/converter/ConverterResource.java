package com.sgcib.currencyconverter.converter;

import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;

import static javax.ws.rs.core.MediaType.APPLICATION_JSON;

@Path("/convert")
public class ConverterResource {

    @GET
    @Produces(APPLICATION_JSON)
    public Money convert(@DefaultValue("0") @QueryParam("amount")float amount) {
        return new Money(amount * 1.309f, "USD");
    }

}
