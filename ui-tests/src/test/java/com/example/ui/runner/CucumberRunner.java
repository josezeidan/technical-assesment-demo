package com.example.ui.runner;

import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;

@CucumberOptions(
        features = "classpath:features",
        glue = {"com.example.ui.steps", "com.example.ui.hooks"},
        plugin = {
                "pretty",
                "html:target/cucumber-reports/report.html",
                "json:target/cucumber-reports/report.json"
        },
        monochrome = true
)
public class CucumberRunner extends AbstractTestNGCucumberTests {
}
