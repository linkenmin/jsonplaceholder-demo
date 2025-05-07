@Albums
Feature: Testing the /albums API

  @FunctionalTest
  Scenario: Get all albums
    When I send a "GET" request to "/albums" with body:
      """
      {}
      """
    Then the response status code should be 200

  @FunctionalTest
  Scenario: Create a new album
    When I send a "POST" request to "/albums" with body:
      """
      {
        "userId": 11,
        "id": 101,
        "title": "mytitle"
      }
      """
    Then the response status code should be 201
    And the response JSON path "id" should be "101"

  @FunctionalTest
  Scenario: Update an existing album
    When I send a "PUT" request to "/albums/1" with body:
      """
      {
        "userId": 11,
        "id": 101,
        "title": "mytitle"
      }
      """
    Then the response status code should be 200
    And the response JSON path "userId" should be "11"
    And the response JSON path "id" should be "1"
    And the response JSON path "title" should be "mytitle"

  @FunctionalTest
  Scenario: Partially update an existing album
    When I send a "PATCH" request to "/albums/1" with body:
      """
      {
        "title": "mytitle"
      }
      """
    Then the response status code should be 200
    And the response JSON path "title" should be "mytitle"

  @FunctionalTest
  Scenario: Delete an existing post
    When I send a "DELETE" request to "/albums/1" with body:
      """
      {}
      """
    Then the response status code should be 200

  @NegativeTest
  Scenario: Get a nonexistent album
    When I send a "GET" request to "/albums/101" with body:
      """
      {}
      """
    Then the response status code should be 404

  @NegativeTest
  Scenario: Send invalid POST data for album
    When I send a "POST" request to "/albums" with body:
      """
      { invalid: data }
      """
    Then the response status code should be 500