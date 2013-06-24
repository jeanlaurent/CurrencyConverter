package com.sgcib.currencyconverter;

import com.google.common.io.Resources;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.net.URL;

import static com.google.common.base.Charsets.UTF_8;
import static org.fest.assertions.api.Assertions.assertThat;

public class ServerTest {

    private Server server;

    @Before
    public void init() {
        server = new Server();
        server.start();
    }

    @After
    public void bye() {
        server.stop();
    }

    @Test
    public void should_serve_home_page() throws Exception {
        String homePage = Resources.toString(new URL("http://localhost:8080/"), UTF_8);
        assertThat(homePage).contains("Currency Converter");
    }

}
