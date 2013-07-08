package com.sgcib.currencyconverter.server;

import org.junit.Test;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Response;

import static org.fest.assertions.Assertions.assertThat;


public class ServerResourceTest {

    @Test
    public void should_find_static_files() {
        ServerResource serverResource = new ServerResource();
        Response response = serverResource.getResource("index.html");
        assertThat(response.getStatus()).isEqualTo(200);
    }

    @Test
    public void should_find_existing_file() {
        ServerResource serverResource = new ServerResource("src/test/resources");
        Response response = serverResource.getResource("exist.txt");
        assertThat(response.getStatus()).isEqualTo(200);
    }

    @Test(expected = WebApplicationException.class)
    public void should_not_find_non_existing_file() {
        ServerResource serverResource = new ServerResource("src/test/resources");
        serverResource.getResource("doesnotexist.txt");
    }

}
