Feature: Update Booking

  Background:
    * url baseUrl
    * def authCookie = 'token=' + authToken

    # Create a booking to operate on
    * def newBooking =
      """
      {
        firstname: 'Update',
        lastname: 'Test',
        totalprice: 150,
        depositpaid: false,
        bookingdates: {
          checkin: '2024-08-01',
          checkout: '2024-08-07'
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

  # ─── Positive Tests ───────────────────────────────────────────────────────────

  Scenario: Full update (PUT) with valid token updates all fields
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
          checkin: '2024-09-01',
          checkout: '2024-09-10'
        },
        additionalneeds: 'Dinner'
      }
      """
    When method PUT
    Then status 200
    And match response.firstname == 'James'
    And match response.lastname == 'Updated'
    And match response.totalprice == 300

  Scenario: Partial update (PATCH) with valid token updates specific fields
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

  # ─── Negative Tests ───────────────────────────────────────────────────────────

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

  Scenario: Partial update (PATCH) without auth token returns 403
    Given path '/booking/' + bookingId
    And header Content-Type = 'application/json'
    And request { firstname: 'NoAuth' }
    When method PATCH
    Then status 403
