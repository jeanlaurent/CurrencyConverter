package com.sgcib.currencyconverter;

import com.sgcib.currencyconverter.converter.ConverterResource;
import com.sgcib.currencyconverter.server.ServerResource;
import org.glassfish.jersey.jackson.JacksonFeature;
import org.glassfish.jersey.server.ResourceConfig;

import javax.ws.rs.ApplicationPath;


@ApplicationPath("/")
public class Server extends ResourceConfig {

    public Server() {
        register(JacksonFeature.class);
        register(ConverterResource.class);
        register(ServerResource.class);
    }

}


