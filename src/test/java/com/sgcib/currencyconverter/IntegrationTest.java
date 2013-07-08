package com.sgcib.currencyconverter;


import com.google.common.base.Predicate;
import com.google.common.base.Strings;
import org.fluentlenium.adapter.FluentTest;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.Test;

import static com.google.common.base.Strings.*;
import static org.fest.assertions.Assertions.assertThat;

//Test currently does not pass under maven
// But runs fine in IDEA.
// We're looking into it.
@Ignore
public class IntegrationTest extends FluentTest {
    private static EmbeddedTomcat embeddedTomcat;

    @BeforeClass
    public static void startupTomcat() throws Exception {
        embeddedTomcat = new EmbeddedTomcat();
        embeddedTomcat.start();
    }

    @AfterClass
    public static void shutdownTomcat() throws Exception {
        embeddedTomcat.stop();
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
