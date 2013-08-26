package com.sgcib.currencyconverter.converter;

import org.glassfish.jersey.client.ClientConfig;
import org.glassfish.jersey.jackson.JacksonFeature;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.test.JerseyTest;
import org.junit.BeforeClass;
import org.junit.Test;

import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.Application;
import java.util.logging.Level;
import java.util.logging.Logger;

import static org.fest.assertions.Assertions.assertThat;

// this test is now redundant

public class ConverterResourceTest extends JerseyTest {

    @BeforeClass
    public static void init() {
        Logger.getLogger("org.glassfish").setLevel(Level.OFF);
    }

    @Test
    public void should_convert_EUR_to_USD() {
        WebTarget target = target();
        Money money = target.path("convert/EUR/USD").queryParam("amount","10").request().get(Money.class);
        assertThat(money.currency).isEqualTo("USD");
        assertThat(money.quantity).isEqualTo(13.09d);
    }

    @Test
    public void should_convert_USD_to_EUR() {
        WebTarget target = target();
        Money money = target.path("convert/USD/EUR").queryParam("amount","10").request().get(Money.class);
        assertThat(money.currency).isEqualTo("EUR");
        assertThat(money.quantity).isEqualTo(7.485d);
    }


    @Override
    protected Application configure() {
        return new ResourceConfig(ConverterResource.class,JacksonFeature.class);
    }

    @Override
    protected void configureClient(ClientConfig clientConfig) {
        clientConfig.register(JacksonFeature.class);
    }
}
