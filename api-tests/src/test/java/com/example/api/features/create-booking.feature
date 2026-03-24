
@CB
Feature: Create Booking

  Background:
    * url baseUrl
    * def validBooking = read('this:../testData/createBookingPayload.json')
    * def validBookingResponseSchema = read('this:../testData/bookingResponseSchema.json')


  @CB-1
  Scenario: Create a new booking returns booking ID and booking data
    Given path '/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request validBooking
    When method POST
    Then status 200
    * print response
    And match response == validBookingResponseSchema


  @CB-2
  Scenario: Create booking and verify persisted values match request
    Given path '/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request validBooking
    When method POST
    Then status 200
    And match response.booking.firstname == 'James'
    And match response.booking.lastname == 'Dean'
    And match response.booking.totalprice == 250
    And match response.booking.depositpaid == true
    And match response.booking.bookingdates.checkin == '2024-06-01'
    And match response.booking.additionalneeds == 'Breakfast'
    * def createdId = response.bookingid

    # Confirm it can be retrieved
    Given path '/booking/' + createdId
    And header Accept = 'application/json'
    When method GET
    Then status 200
    And match response.firstname == 'James'

  Scenario: Create booking without additionalneeds field
    Given path '/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request
      """
      {
        firstname: 'Anna',
        lastname: 'Smith',
        totalprice: 100,
        depositpaid: false,
        bookingdates: {
          checkin: '2024-07-01',
          checkout: '2024-07-05'
        }
      }
      """
    When method POST
    Then status 200
    And match response.bookingid == '#number'

  @CB-3
  Scenario: Create booking with empty body returns 500
    Given path '/booking'
    And header Content-Type = 'application/json'
    And request {}
    When method POST
    Then status 500
