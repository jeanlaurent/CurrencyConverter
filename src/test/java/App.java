import com.google.common.base.Throwables;
import com.sgcib.currencyconverter.Server;
import com.sun.net.httpserver.HttpServer;

import java.net.URI;
import java.net.URISyntaxException;

import static org.glassfish.jersey.jdkhttp.JdkHttpServerFactory.createHttpServer;

public class App {


    public static void main(String[] args) {
        try {
            HttpServer httpServer = createHttpServer(new URI("http://localhost:8282/"), new Server());
        } catch (URISyntaxException use) {
            Throwables.propagate(use);
        }
    }
}