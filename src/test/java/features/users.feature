@Users
Feature: Testing the /users API

  @FunctionalTest
  Scenario: Get all users
    When I send a "GET" request to "/users" with body:
      """
      {}
      """
    Then the response status code should be 200

  @FunctionalTest
  Scenario: Create a new user
    When I send a "POST" request to "/users" with body:
      """
      {
        "id": 11,
        "name": "myname",
        "username": "myusername",
        "email": "myemail@myemail.com",
        "address": {
          "street": "mystreet",
          "suite": "mysuite",
          "city": "mycity",
          "zipcode": "12345-6789",
          "geo": {
            "lat": "123.456",
            "lng": "654.321"
          }
        },
        "phone": "1-234-567-8901",
        "website": "myweb.site",
        "company": {
          "name": "myname",
          "catchPhrase": "mycatchphrase",
          "bs": "mybs"
        }
      }
      """
    Then the response status code should be 201
    And the response JSON path "id" should be "11"

  @FunctionalTest
  Scenario: Update an existing post
    When I send a "PUT" request to "/users/1" with body:
      """
      {
        "id": 11,
        "name": "myname",
        "username": "myusername",
        "email": "myemail@myemail.com",
        "address": {
          "street": "mystreet",
          "suite": "mysuite",
          "city": "mycity",
          "zipcode": "12345-6789",
          "geo": {
            "lat": "123.456",
            "lng": "654.321"
          }
        },
        "phone": "1-234-567-8901",
        "website": "myweb.site",
        "company": {
          "name": "myname",
          "catchPhrase": "mycatchphrase",
          "bs": "mybs"
        }
      }
      """
    Then the response status code should be 200
    And the response JSON path "id" should be "1"
    And the response JSON path "name" should be "myname"
    And the response JSON path "username" should be "myusername"
    And the response JSON path "email" should be "myemail@myemail.com"
    And the response JSON path "address.street" should be "mystreet"
    And the response JSON path "address.suite" should be "mysuite"
    And the response JSON path "address.city" should be "mycity"
    And the response JSON path "address.zipcode" should be "12345-6789"
    And the response JSON path "address.geo.lat" should be "123.456"
    And the response JSON path "address.geo.lng" should be "654.321"
    And the response JSON path "phone" should be "1-234-567-8901"
    And the response JSON path "website" should be "myweb.site"
    And the response JSON path "company.name" should be "myname"
    And the response JSON path "company.catchPhrase" should be "mycatchphrase"
    And the response JSON path "company.bs" should be "mybs"

  @FunctionalTest
  Scenario: Partially update an existing post
    When I send a "PATCH" request to "/users/1" with body:
      """
      {
        "name": "myname"
      }
      """
    Then the response status code should be 200
    And the response JSON path "name" should be "myname"

  @FunctionalTest
  Scenario: Delete an existing post
    When I send a "DELETE" request to "/users/1" with body:
      """
      {}
      """
    Then the response status code should be 200

  @NegativeTest
  Scenario: Get a nonexistent user
    When I send a "GET" request to "/users/11" with body:
      """
      {}
      """
    Then the response status code should be 404

  @NegativeTest
  Scenario: Send invalid POST data for user
    When I send a "POST" request to "/users" with body:
      """
      { invalid: data }
      """
    Then the response status code should be 500