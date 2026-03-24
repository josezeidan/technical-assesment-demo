package com.example.ui.pages;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.ui.ExpectedConditions;

public class CheckoutStepOnePage extends BasePage {

    @FindBy(id = "first-name")
    private WebElement firstNameInput;

    @FindBy(id = "last-name")
    private WebElement lastNameInput;

    @FindBy(id = "postal-code")
    private WebElement postalCodeInput;

    @FindBy(id = "continue")
    private WebElement continueButton;

    @FindBy(css = "[data-test='error']")
    private WebElement errorMessage;

    public CheckoutStepOnePage(WebDriver driver) {
        super(driver);
    }

    public CheckoutStepTwoPage fillAndContinue(String firstName, String lastName, String postalCode) {
        wait.until(ExpectedConditions.urlContains("checkout-step-one"));
        setReactInputValue("first-name", firstName);
        setReactInputValue("last-name", lastName);
        setReactInputValue("postal-code", postalCode);
        wait.until(ExpectedConditions.elementToBeClickable(By.id("continue"))).click();
        wait.until(ExpectedConditions.urlContains("checkout-step-two"));
        return new CheckoutStepTwoPage(driver);
    }

    private void setReactInputValue(String fieldId, String value) {
        WebElement element = driver.findElement(By.id(fieldId));
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript(
            "var setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;" +
            "setter.call(arguments[0], arguments[1]);" +
            "arguments[0].dispatchEvent(new Event('input', { bubbles: true }));",
            element, value
        );
    }

    public void clickContinueWithoutData() {
        continueButton.click();
    }

    public String getErrorMessage() {
        return errorMessage.getText();
    }
}
