package com.sgcib.currencyconverter.converter;

import com.google.common.annotations.VisibleForTesting;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import java.io.File;
import java.io.IOException;

import static javax.ws.rs.core.MediaType.TEXT_HTML;

@Path("/")
public class ServerResource {
    private final File webHome;

    public ServerResource() {
        this.webHome = new File("web");
    }

    public ServerResource(String webHome) {
        this.webHome = new File(webHome);
    }

    @GET
    @Produces(TEXT_HTML)
    public File serverIndex() {
        return serveFile("index.html");
    }

    @GET
    @Produces(TEXT_HTML)
    @Path("{path : .*\\.html}")
    public File serveFile(@PathParam("path") String path) {
        return getFile(path);
    }

    @VisibleForTesting
    /*package*/ File getFile(String path) {
        File file = new File(webHome, path);
        if (!exist(file)) {
            throw new WebApplicationException(404);
        }
        return file;
    }

    private boolean exist(File file) {
        if (!file.exists()) {
            return false;
        }
        try {
            return (file.getCanonicalPath().startsWith(webHome.getCanonicalPath()));
        } catch (IOException e) {
            return false;
        }
    }

}
