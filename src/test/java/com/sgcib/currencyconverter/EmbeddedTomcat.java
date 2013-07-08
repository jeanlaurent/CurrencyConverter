package com.sgcib.currencyconverter;

import org.apache.catalina.Context;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.startup.Tomcat;
import org.apache.naming.resources.VirtualDirContext;

import javax.servlet.ServletException;
import java.io.File;

public class EmbeddedTomcat {
    private String webappPath = new File("src/main/webapp/").getAbsolutePath();
    private String additionWebInfClasses = new File("target/classes/").getAbsolutePath();
    private Tomcat tomcat;

    public void start() throws LifecycleException, ServletException {
        tomcat = new Tomcat();
        tomcat.setPort(8181);
        Context context = tomcat.addWebapp("/", webappPath);
        VirtualDirContext resources = new VirtualDirContext();
        resources.setExtraResourcePaths("/WEB-INF/classes=" + additionWebInfClasses);
        context.setResources(resources);
        tomcat.start();
    }

    public void startAndWait() throws ServletException, LifecycleException {
        start();
        tomcat.getServer().await();
    }

    public void stop() throws LifecycleException {
        tomcat.stop();
    }


}
