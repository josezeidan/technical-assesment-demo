package com.example.ui.steps;

import com.example.ui.context.ScenarioContext;
import com.example.ui.pages.InventoryPage;
import com.example.ui.pages.LoginPage;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import static org.testng.Assert.*;

public class LoginSteps {

    private final ScenarioContext context;

    public LoginSteps(ScenarioContext context) {
        this.context = context;
    }

    @Given("I am on the login page")
    public void iAmOnTheLoginPage() {
        context.loginPage = new LoginPage(context.driver).open();
    }

    @When("I log in as {string} with password {string}")
    public void iLogInAs(String username, String password) {
        context.loginPage.login(username, password);
    }

    @Then("I should be on the inventory page")
    public void iShouldBeOnInventoryPage() {
        assertTrue(context.driver.getCurrentUrl().contains("inventory"));
    }

    @And("the page title should be {string}")
    public void thePageTitleShouldBe(String expectedTitle) {
        context.inventoryPage = new InventoryPage(context.driver);
        System.out.println("Title is :"+context.inventoryPage.getPageTitle());
        assertEquals(context.inventoryPage.getPageTitle(), expectedTitle);

    }

    @Then("I should see login error containing {string}")
    public void iShouldSeeLoginErrorContaining(String errorText) {
        assertTrue(context.loginPage.isErrorDisplayed(),
                "Expected an error message to be visible");
        assertTrue(context.loginPage.getErrorMessage().contains(errorText),
                "Expected error to contain '" + errorText + "' but was: " + context.loginPage.getErrorMessage());
    }
}
