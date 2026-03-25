@CB @regression
Feature: Create Booking

  Background:
    * url baseUrl
    * def validBooking = read('this:../testData/createBookingPayload.json')
    * def validBookingResponseSchema = read('this:../testData/bookingResponseSchema.json')

  @CB-1
  Scenario Outline: Verify creating a new booking returns booking ID and booking data
    * set validBooking.firstname = '<firstname>'
    * set validBooking.lastname = '<lastname>'
    * set validBooking.totalprice = <totalprice>
    * set validBooking.depositpaid = <depositpaid>
    * set validBooking.bookingdates.checkin = '<checkin>'
    * set validBooking.bookingdates.checkout = '<checkout>'
    * set validBooking.additionalneeds = '<additionalneeds>'
    Given path '/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request validBooking
    When method POST
    Then status 200
    * print response
    And match response == validBookingResponseSchema
    And match response.bookingid == '#number'
    And match response.booking.firstname == '<firstname>'
    And match response.booking.lastname == '<lastname>'
    And match response.booking.totalprice == <totalprice>
    And match response.booking.depositpaid == <depositpaid>
    And match response.booking.bookingdates.checkin == '<checkin>'
    And match response.booking.bookingdates.checkout == '<checkout>'
    And match response.booking.additionalneeds == '<additionalneeds>'

    Examples:
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | James     | Dean     | 250        | true        | 2026-04-10 | 2026-04-20 | Breakfast       |
      | Anna      | Smith    | 100        | false       | 2026-05-01 | 2026-05-07 | Lunch           |
      | Bob       | Johnson  | 500        | true        | 2026-06-15 | 2026-06-22 | Dinner          |

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

    Given path '/booking/' + createdId
    And header Accept = 'application/json'
    When method GET
    Then status 200
    And match response.firstname == 'James'

  @CB-3
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
    * print response
    And match response.bookingid == '#number'

  @CB-4
  Scenario: Create booking with empty body returns 500
    Given path '/booking'
    And header Content-Type = 'application/json'
    And request {}
    When method POST
    Then status 500
