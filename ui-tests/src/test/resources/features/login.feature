Feature: Login functionality on SauceDemo

  @LI-1
  Scenario: Successful login with valid credentials navigates to products page
    Given I am on the login page
    When I log in as "standard_user" with password "secret_sauce"
    Then I should be on the inventory page
    And the page title should be "Products"

  Scenario: Locked out user sees an error message
    Given I am on the login page
    When I log in as "locked_out_user" with password "secret_sauce"
    Then I should see login error containing "locked out"

  Scenario Outline: Invalid or empty credentials display the correct error
    Given I am on the login page
    When I log in as "<username>" with password "<password>"
    Then I should see login error containing "<error>"

    Examples:
      | username       | password     | error                              |
      | invalid_user   | wrong_pass   | Username and password do not match |
      |                | secret_sauce | Username is required               |
      | standard_user  |              | Password is required               |
