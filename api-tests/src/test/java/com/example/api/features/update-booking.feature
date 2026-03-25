@UB @regression
Feature: Update Booking

  Background:
    * url baseUrl
    * def authCookie = 'token=' + authToken

    * def newBooking =
      """
      {
        firstname: 'Update',
        lastname: 'Test',
        totalprice: 150,
        depositpaid: false,
        bookingdates: {
          checkin: '2026-08-01',
          checkout: '2026-08-07'
        },
        additionalneeds: 'Lunch'
      }
      """
    Given path '/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request newBooking
    When method POST
    Then status 200
    * def bookingId = response.bookingid

  @UB-1
  Scenario: Verify 200 and updated booking data after valid authenticated PUT request
    Given path '/booking/' + bookingId
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = authCookie
    And request
      """
      {
        firstname: 'James',
        lastname: 'Updated',
        totalprice: 300,
        depositpaid: true,
        bookingdates: {
          checkin: '2026-09-01',
          checkout: '2026-09-10'
        },
        additionalneeds: 'Dinner'
      }
      """
    When method PUT
    Then status 200
    And match response.firstname == 'James'
    And match response.lastname == 'Updated'
    And match response.totalprice == 300
    And match response.depositpaid == true
    And match response.bookingdates.checkin == '2026-09-01'
    And match response.bookingdates.checkout == '2026-09-10'
    And match response.additionalneeds == 'Dinner'

  @UB-2
  Scenario: Verify 200 and booking data is partially updated after valid authenticated PATCH request
    Given path '/booking/' + bookingId
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And header Cookie = authCookie
    And request { firstname: 'Patched', totalprice: 999 }
    When method PATCH
    Then status 200
    And match response.firstname == 'Patched'
    And match response.totalprice == 999
    And match response.lastname == 'Test'

  @UB-3
  Scenario: Full update (PUT) without auth token returns 403
    Given path '/booking/' + bookingId
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request
      """
      {
        firstname: 'NoAuth',
        lastname: 'Test',
        totalprice: 100,
        depositpaid: false,
        bookingdates: {
          checkin: '2024-08-01',
          checkout: '2024-08-07'
        }
      }
      """
    When method PUT
    Then status 403

  @UB-4
  Scenario: Partial update (PATCH) without auth token returns 403
    Given path '/booking/' + bookingId
    And header Content-Type = 'application/json'
    And request { firstname: 'NoAuth' }
    When method PATCH
    Then status 403