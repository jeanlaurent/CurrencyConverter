import com.sgcib.currencyconverter.EmbeddedJetty;

import static com.google.common.base.Throwables.*;

public class App {

    public static void main(String[] args) {
        try {
            new EmbeddedJetty(8282).startAndJoin();
        } catch (Exception use) {
            propagate(use);
        }
    }

}