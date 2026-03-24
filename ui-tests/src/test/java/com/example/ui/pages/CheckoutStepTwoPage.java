package com.example.ui.pages;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.ui.ExpectedConditions;

public class CheckoutStepTwoPage extends BasePage {

    @FindBy(css = ".summary_total_label")
    private WebElement totalLabel;

    @FindBy(css = ".summary_subtotal_label")
    private WebElement subtotalLabel;

    @FindBy(id = "finish")
    private WebElement finishButton;

    @FindBy(id = "cancel")
    private WebElement cancelButton;

    public CheckoutStepTwoPage(WebDriver driver) {
        super(driver);
    }

    public String getTotal() {
        return totalLabel.getText();
    }

    public String getSubtotal() {
        return subtotalLabel.getText();
    }

    public CheckoutCompletePage clickFinish() {
        WebElement btn = wait.until(ExpectedConditions.elementToBeClickable(By.id("finish")));
        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", btn);
        return new CheckoutCompletePage(driver);
    }

    public InventoryPage clickCancel() {
        cancelButton.click();
        return new InventoryPage(driver);
    }
}
