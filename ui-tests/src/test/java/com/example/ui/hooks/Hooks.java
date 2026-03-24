package com.example.ui.hooks;

import com.example.ui.context.ScenarioContext;
import io.cucumber.java.After;
import io.cucumber.java.Before;
import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

public class Hooks {

    private final ScenarioContext context;

    public Hooks(ScenarioContext context) {
        this.context = context;
    }

    @Before
    public void setUp() {
        WebDriverManager.chromedriver().setup();
        ChromeOptions options = new ChromeOptions();
        boolean headless = !"false".equalsIgnoreCase(System.getProperty("headless", "true"));
        if (headless) {
            options.addArguments("--headless=new");
            options.addArguments("--no-sandbox");
            options.addArguments("--disable-dev-shm-usage");
        }
        context.driver = new ChromeDriver(options);
        context.driver.manage().window().setSize(new Dimension(1920, 1080));
    }

    @After
    public void tearDown() {
        if (context.driver != null) {
            context.driver.quit();
            context.driver = null;
        }
    }
}
