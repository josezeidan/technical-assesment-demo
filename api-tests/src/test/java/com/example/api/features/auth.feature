@token
Feature: Authentication

  Scenario: Obtain auth token with valid credentials
    Given url 'https://restful-booker.herokuapp.com/auth'
    And header Content-Type = 'application/json'
    And request { username: 'admin', password: 'password123' }
    When method POST
    Then status 200
    And match response.token == '#string'
    * def token = response.token
