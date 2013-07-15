package com.sgcib.currencyconverter;


import com.google.common.base.Predicate;
import org.fluentlenium.adapter.FluentTest;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import static com.google.common.base.Strings.isNullOrEmpty;
import static org.fest.assertions.Assertions.assertThat;

public class IntegrationTest extends FluentTest {
    private static EmbeddedJetty jetty;

    @BeforeClass
    public static void startupTomcat() throws Exception {
        jetty = new EmbeddedJetty();
        jetty.start();
    }

    @AfterClass
    public static void shutdownTomcat() throws Exception {
        jetty.stop();
    }

    @Test
    public void should_convert_euros_to_dollar() throws Exception {
        goTo("http://localhost:8181/");
        fill("#quantity").with("4");
        click("#convert");
        waitForValue(2000, "#result");
        assertThat(find("#result").getValue()).isEqualTo("5.24");
    }

    private void waitForValue(int timeInMillis, final String target) {
        await().atMost(timeInMillis).until(new Predicate() {
            @Override
            public boolean apply(Object input) {
                return !isNullOrEmpty(find(target).getValue());
            }
        });
    }

}
