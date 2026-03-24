package com.example.ui.pages;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

public class LoginPage extends BasePage {

    public static final String URL = "https://www.saucedemo.com";

    @FindBy(id = "user-name")
    private WebElement usernameInput;

    @FindBy(id = "password")
    private WebElement passwordInput;

    @FindBy(id = "login-button")
    private WebElement loginButton;

    @FindBy(css = "[data-test='error']")
    private WebElement errorMessage;

    public LoginPage(WebDriver driver) {
        super(driver);
    }

    public LoginPage open() {
        driver.get(URL);
        return this;
    }

    public void login(String username, String password) {
        usernameInput.clear();
        usernameInput.sendKeys(username);
        passwordInput.clear();
        passwordInput.sendKeys(password);
        loginButton.click();
    }

    public InventoryPage loginSuccessfully(String username, String password) {
        login(username, password);
        return new InventoryPage(driver);
    }

    public String getErrorMessage() {
        return errorMessage.getText();
    }

    public boolean isErrorDisplayed() {
        try {
            return errorMessage.isDisplayed();
        } catch (Exception e) {
            return false;
        }
    }
}
