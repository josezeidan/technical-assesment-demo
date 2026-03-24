package com.example.ui.pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;

import java.util.List;
import java.util.stream.Collectors;

public class InventoryPage extends BasePage {

    @FindBy(css = ".title")
    private WebElement pageTitle;

    @FindBy(css = ".inventory_item")
    private List<WebElement> inventoryItems;

    @FindBy(css = ".shopping_cart_link")
    private WebElement cartIcon;

    @FindBy(css = ".shopping_cart_badge")
    private WebElement cartBadge;

    public InventoryPage(WebDriver driver) {
        super(driver);
    }

    public String getPageTitle() {
        return pageTitle.getText();
    }

    public List<String> getProductNames() {
        return inventoryItems.stream()
                .map(item -> item.findElement(By.cssSelector(".inventory_item_name")).getText())
                .collect(Collectors.toList());
    }

    public void addItemToCartByName(String itemName) {
        String xpath = "//div[contains(@class,'inventory_item_name')][normalize-space(text())='" + itemName
                + "']/ancestor::div[contains(@class,'inventory_item')]//button[contains(@data-test,'add-to-cart')]";
        driver.findElement(By.xpath(xpath)).click();
    }

    public int getCartItemCount() {
        try {
            return Integer.parseInt(cartBadge.getText());
        } catch (Exception e) {
            return 0;
        }
    }

    public CartPage goToCart() {
        cartIcon.click();
        return new CartPage(driver);
    }
}
