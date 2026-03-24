package com.example.ui.context;

import com.example.ui.pages.*;
import org.openqa.selenium.WebDriver;

/**
 * Shared state between step definitions for a single Cucumber scenario.
 * PicoContainer creates a new instance per scenario.
 */
public class ScenarioContext {

    public WebDriver driver;

    public LoginPage loginPage;
    public InventoryPage inventoryPage;
    public CartPage cartPage;
    public CheckoutStepOnePage checkoutStepOnePage;
    public CheckoutStepTwoPage checkoutStepTwoPage;
    public CheckoutCompletePage checkoutCompletePage;
}
