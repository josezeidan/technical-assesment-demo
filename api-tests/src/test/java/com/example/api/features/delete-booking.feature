@DB @regression
Feature: Delete Booking

  Background:
    * url baseUrl
    * def authCookie = 'token=' + authToken
    Given path '/booking'
    And header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And request
      """
      {
        firstname: 'Delete',
        lastname: 'Me',
        totalprice: 50,
        depositpaid: false,
        bookingdates: {
          checkin: '2026-10-01',
          checkout: '2026-10-03'
        }
      }
      """
    When method POST
    Then status 200
    * def bookingId = response.bookingid

  @DB-1
  Scenario: Delete booking with valid token returns 201
    Given path '/booking/' + bookingId
    And header Cookie = authCookie
    When method DELETE
    Then status 201

  @DB-2
  Scenario: Deleted booking is no longer accessible
    Given path '/booking/' + bookingId
    And header Cookie = authCookie
    When method DELETE
    Then status 201

    Given path '/booking/' + bookingId
    And header Accept = 'application/json'
    When method GET
    Then status 404

  @DB-3
  Scenario: Delete booking without auth token returns 403
    Given path '/booking/' + bookingId
    When method DELETE
    Then status 403
