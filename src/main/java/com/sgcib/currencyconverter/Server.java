package com.sgcib.currencyconverter;

import com.google.common.base.Throwables;
import com.sgcib.currencyconverter.converter.ConverterResource;
import com.sgcib.currencyconverter.server.ServerResource;
import com.sun.net.httpserver.HttpServer;
import org.glassfish.jersey.jackson.JacksonFeature;
import org.glassfish.jersey.server.ResourceConfig;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.logging.Level;
import java.util.logging.Logger;

import static org.glassfish.jersey.jdkhttp.JdkHttpServerFactory.createHttpServer;

public class Server {
    private HttpServer httpServer;

    public void start()  {
        ResourceConfig config = new ResourceConfig();
        config.register(JacksonFeature.class);
        config.register(ServerResource.class);
        config.register(ConverterResource.class);
        try {
            httpServer = createHttpServer(new URI("http://localhost:8080/"), config);
        } catch (URISyntaxException use) {
            Throwables.propagate(use);
        }
    }

    public void stop() {
        httpServer.stop(0);
    }

    public static void main(String[] args)  {
        Logger.getLogger("org.glassfish").setLevel(Level.OFF);
        new Server().start();
    }

}

