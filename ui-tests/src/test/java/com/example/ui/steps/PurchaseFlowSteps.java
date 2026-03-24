package com.example.ui.steps;

import com.example.ui.context.ScenarioContext;
import com.example.ui.pages.LoginPage;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import static org.testng.Assert.*;

public class PurchaseFlowSteps {

    private final ScenarioContext context;

    public PurchaseFlowSteps(ScenarioContext context) {
        this.context = context;
    }

    @Given("I am logged in as {string} with password {string}")
    public void iAmLoggedInAs(String username, String password) {
        context.inventoryPage = new LoginPage(context.driver)
                .open()
                .loginSuccessfully(username, password);
    }

    @When("I add {string} to the cart")
    public void iAddItemToTheCart(String itemName) {
        context.inventoryPage.addItemToCartByName(itemName);
    }

    @Then("the cart badge should show {int} items")
    public void theCartBadgeShouldShow(int expectedCount) {
        assertEquals(context.inventoryPage.getCartItemCount(), expectedCount);
    }

    @When("I go to the cart")
    public void iGoToTheCart() {
        context.cartPage = context.inventoryPage.goToCart();
    }

    @And("I proceed to checkout")
    public void iProceedToCheckout() {
        context.checkoutStepOnePage = context.cartPage.clickCheckout();
    }

    @And("I fill in first name {string}, last name {string}, and postal code {string}")
    public void iFillInCheckoutInfo(String firstName, String lastName, String postalCode) {
        context.checkoutStepTwoPage = context.checkoutStepOnePage
                .fillAndContinue(firstName, lastName, postalCode);
    }

    @And("I finish the order")
    public void iFinishTheOrder() {
        context.checkoutCompletePage = context.checkoutStepTwoPage.clickFinish();
    }

    @Then("I should see the order confirmation {string}")
    public void iShouldSeeOrderConfirmation(String expectedHeader) {
        assertEquals(context.checkoutCompletePage.getCompleteHeader(), expectedHeader);
    }
}
