@Photos
Feature: Testing the /photos API

  @FunctionalTest
  Scenario: Get all photos
    When I send a "GET" request to "/photos" with body:
      """
      {}
      """
    Then the response status code should be 200

  @FunctionalTest
  Scenario: Create a new photo
    When I send a "POST" request to "/photos" with body:
      """
      {
        "albumId": 101,
        "id": 5001,
        "title": "mytitle",
        "url": "https://www.myurl.com/abc/123",
        "thumbnailUrl": "https://www.myurl.com/abc/123"
      }
      """
    Then the response status code should be 201
    And the response JSON path "id" should be "5001"

  @FunctionalTest
  Scenario: Update an existing album
    When I send a "PUT" request to "/photos/1" with body:
      """
      {
        "albumId": 101,
        "id": 5001,
        "title": "mytitle",
        "url": "https://www.myurl.com/abc/123",
        "thumbnailUrl": "https://www.myurl.com/abc/123"
      }
      """
    Then the response status code should be 200
    And the response JSON path "albumId" should be "101"
    And the response JSON path "id" should be "1"
    And the response JSON path "title" should be "mytitle"
    And the response JSON path "url" should be "https://www.myurl.com/abc/123"
    And the response JSON path "thumbnailUrl" should be "https://www.myurl.com/abc/123"

  @FunctionalTest
  Scenario: Partially update an existing photo
    When I send a "PATCH" request to "/photos/1" with body:
      """
      {
        "title": "mytitle"
      }
      """
    Then the response status code should be 200
    And the response JSON path "title" should be "mytitle"

  @FunctionalTest
  Scenario: Delete an existing post
    When I send a "DELETE" request to "/photos/1" with body:
      """
      {}
      """
    Then the response status code should be 200

  @NegativeTest
  Scenario: Get a nonexistent photo
    When I send a "GET" request to "/photos/5001" with body:
      """
      {}
      """
    Then the response status code should be 404

  @NegativeTest
  Scenario: Send invalid POST data for photo
    When I send a "POST" request to "/photos" with body:
      """
      { invalid: data }
      """
    Then the response status code should be 500