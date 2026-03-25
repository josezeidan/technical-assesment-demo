@PF @smoke
Feature: Purchase flow on SauceDemo

  Background:
    Given I am logged in as "standard_user" with password "secret_sauce"

  @PF-1
  Scenario: Adding an item updates the cart badge
    When I add "Sauce Labs Backpack" to the cart
    Then the cart badge should show 1 items

  @PF-2
  Scenario: Adding multiple items updates the cart count correctly
    When I add "Sauce Labs Backpack" to the cart
    And I add "Sauce Labs Bike Light" to the cart
    Then the cart badge should show 2 items

  @PF-3
  Scenario: Complete full purchase journey from inventory to order confirmation
    When I add "Sauce Labs Backpack" to the cart
    And I go to the cart
    And I proceed to checkout
    And I fill in first name "John", last name "Doe", and postal code "12345"
    And I finish the order
    Then I should see the order confirmation "Thank you for your order!"