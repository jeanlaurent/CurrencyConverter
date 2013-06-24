package com.sgcib.currencyconverter.server;

import com.sgcib.currencyconverter.server.ServerResource;
import org.junit.Test;

import javax.ws.rs.WebApplicationException;
import java.io.File;

import static org.fest.assertions.api.Assertions.assertThat;

public class ServerResourceTest {

    @Test
    public void should_find_static_files() {
        ServerResource serverResource = new ServerResource();
        File file = serverResource.getFile("index.html");
        assertThat(file).isNotNull();
    }

    @Test
    public void should_find_existing_file() {
        ServerResource serverResource = new ServerResource("src/test/resources");
        File exist = serverResource.getFile("exist.txt");
        assertThat(exist).isNotNull();
    }

    @Test(expected = WebApplicationException.class)
    public void should_not_find_non_existing_file() {
        ServerResource serverResource = new ServerResource("src/test/resources");
        serverResource.getFile("doesnotexist.txt");
    }

}
