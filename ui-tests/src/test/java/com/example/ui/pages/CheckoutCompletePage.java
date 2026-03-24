package com.example.ui.pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.ui.ExpectedConditions;

public class CheckoutCompletePage extends BasePage {

    @FindBy(css = ".complete-header")
    private WebElement completeHeader;

    @FindBy(css = ".complete-text")
    private WebElement completeText;

    @FindBy(id = "back-to-products")
    private WebElement backToProductsButton;

    public CheckoutCompletePage(WebDriver driver) {
        super(driver);
    }

    public String getCompleteHeader() {
        new org.openqa.selenium.support.ui.WebDriverWait(driver, java.time.Duration.ofSeconds(20))
                .until(ExpectedConditions.urlContains("checkout-complete"));
        return wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(".complete-header"))).getText();
    }

    public String getCompleteText() {
        return completeText.getText();
    }

    public InventoryPage clickBackToProducts() {
        backToProductsButton.click();
        return new InventoryPage(driver);
    }
}
