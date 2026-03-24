package com.example.ui.pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import java.util.List;
import java.util.stream.Collectors;

public class CartPage extends BasePage {

    @FindBy(css = ".cart_item")
    private List<WebElement> cartItems;

    @FindBy(id = "checkout")
    private WebElement checkoutButton;

    @FindBy(id = "continue-shopping")
    private WebElement continueShoppingButton;

    public CartPage(WebDriver driver) {
        super(driver);
    }

    public int getItemCount() {
        return cartItems.size();
    }

    public List<String> getItemNames() {
        return cartItems.stream()
                .map(item -> item.findElement(By.cssSelector(".inventory_item_name")).getText())
                .collect(Collectors.toList());
    }

    public CheckoutStepOnePage clickCheckout() {
        checkoutButton.click();
        return new CheckoutStepOnePage(driver);
    }

    public InventoryPage continueShopping() {
        continueShoppingButton.click();
        return new InventoryPage(driver);
    }
}
