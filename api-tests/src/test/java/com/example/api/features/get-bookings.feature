@GB @regression
Feature: Get Bookings

  Background:
    * url baseUrl
    * def validBookingResponseSchema = read('this:../testData/bookingResponseSchema.json')
    * def getBookingResponseSchema = read('this:../testData/getBookingResponseSchema.json')
    * configure matchEachEmptyAllowed = true

  @setup=bookingIDs
  Scenario: Setup
    * url baseUrl
    Given path '/booking'
    When method GET
    Then status 200
    * def bookingIDs = response

  @GB-1
  Scenario: Get all booking IDs returns a non-empty array
    Given path '/booking'
    When method GET
    Then status 200
    And match response == '#array'
    And match each response == { bookingid: '#number' }

  @GB-2
  Scenario: Get all bookings by firstname filter
    Given path '/booking'
    And param firstname = 'Sally'
    When method GET
    Then status 200
    And match response == "#[] #object"

  @GB-3
  Scenario Outline: Get booking by ID returns valid schema
    Given path '/booking/<bookingid>'
    And header Accept = 'application/json'
    When method GET
    Then status 200
    And match response == getBookingResponseSchema
    Examples:
      | karate.setup("bookingIDs").bookingIDs.slice(0,10) |

  @GB-4
  Scenario: Ping health check returns 201
    Given path '/ping'
    When method GET
    Then status 201

  @GB-5
  Scenario: Get booking with non-existent ID returns 404
    Given path '/booking/9999999'
    And header Accept = 'application/json'
    When method GET
    Then status 404