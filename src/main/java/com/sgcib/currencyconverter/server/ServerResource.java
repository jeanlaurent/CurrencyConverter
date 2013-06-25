package com.sgcib.currencyconverter.server;

import com.google.common.annotations.VisibleForTesting;
import com.google.common.io.Resources;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Response;
import java.io.File;
import java.io.IOException;
import java.net.URL;

import static com.sgcib.currencyconverter.server.MediaType.APPLICATION_JAVASCRIPT;
import static com.sgcib.currencyconverter.server.MediaType.TEXT_CSS;
import static com.sgcib.currencyconverter.server.MediaType.TEXT_HTML;

@Path("/")
public class ServerResource {
    private final File webHome;

    public ServerResource() {
        this.webHome = new File("src/main/webapp");
    }

    public ServerResource(String webHome) {
        this.webHome = new File(webHome);
    }

    @GET
    @Produces(TEXT_HTML)
    public Response serverIndex() {
        return serveHtml("index.html");
    }

    @GET
    @Produces(TEXT_HTML)
    @Path("{path : .*\\.html}")
    public Response serveHtml(@PathParam("path") String path) {
        return getResource(path);
    }

    @GET
    @Produces(TEXT_CSS)
    @Path("{path : .*\\.css}")
    public Response serveCss(@PathParam("path") String path) {
        return getResource(path);
    }

    @GET
    @Produces(APPLICATION_JAVASCRIPT)
    @Path("{path : .*\\.js}")
    public Response serveJavascript(@PathParam("path") String path) {
        return getResource(path);
    }

    @VisibleForTesting
    /*package*/ Response getResource(String path) {
        File file = new File(webHome, path);
        if (!exist(file)) {
            try {
                System.out.println(path);
                System.out.println(getClass().getClassLoader().getResource(path));
                System.out.println("before getResource");
                URL url = Resources.getResource(path);
                System.out.println(url);
                return Response.ok(url.openStream()).build();
            } catch (IOException | IllegalArgumentException exception) {
                System.out.println("FAIL");
                System.out.println(exception.getMessage());
                throw new WebApplicationException(404);
            }
        }
        return Response.ok(file).build();
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
