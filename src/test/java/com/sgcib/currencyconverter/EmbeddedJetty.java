package com.sgcib.currencyconverter;

import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.webapp.WebAppContext;

import java.io.File;

public class EmbeddedJetty {
    private final int port;
    private Server server;

    public EmbeddedJetty() {
        this.port = 8181;
    }

    public EmbeddedJetty(int port) {
        this.port = port;
    }

    public static void main(String[] args) throws Exception {
        new EmbeddedJetty().startAndJoin();
    }

    public void start() throws Exception {
        server = new Server(this.port);
        WebAppContext context = new WebAppContext();
        context.setResourceBase(new File("src/main/webapp").getAbsolutePath());
        context.setContextPath("/");
        context.setParentLoaderPriority(true);
        server.setHandler(context);
        server.start();
    }

    public void startAndJoin() throws Exception {
        start();
        server.join();
    }

    public void stop() throws Exception {
        server.stop();
    }


}
