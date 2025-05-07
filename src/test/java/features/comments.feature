@Comments
Feature: Testing the /comments API

  @FunctionalTest
  Scenario: Get all comments
    When I send a "GET" request to "/comments" with body:
      """
      {}
      """
    Then the response status code should be 200

  @FunctionalTest
  Scenario: Create a new comment
    When I send a "POST" request to "/comments" with body:
      """
      {
        "postId": 101,
        "id": 501,
        "name": "myname",
        "email": "myemail@mymeail.com",
        "body": "mybody"
      }
      """
    Then the response status code should be 201
    And the response JSON path "id" should be "501"

  @FunctionalTest
  Scenario: Update an existing album
    When I send a "PUT" request to "/comments/1" with body:
      """
      {
        "postId": 101,
        "id": 501,
        "name": "myname",
        "email": "myemail@mymeail.com",
        "body": "mybody"
      }
      """
    Then the response status code should be 200
    And the response JSON path "postId" should be "101"
    And the response JSON path "id" should be "1"
    And the response JSON path "email" should be "myemail@mymeail.com"
    And the response JSON path "body" should be "mybody"

  @FunctionalTest
  Scenario: Partially update an existing album
    When I send a "PATCH" request to "/comments/1" with body:
      """
      {
        "body": "mybody"
      }
      """
    Then the response status code should be 200
    And the response JSON path "body" should be "mybody"

  @FunctionalTest
  Scenario: Delete an existing post
    When I send a "DELETE" request to "/comments/1" with body:
      """
      {}
      """
    Then the response status code should be 200

  @NegativeTest
  Scenario: Get a nonexistent comment
    When I send a "GET" request to "/comments/501" with body:
      """
      {}
      """
    Then the response status code should be 404

  @NegativeTest
  Scenario: Send invalid POST data for comment
    When I send a "POST" request to "/comments" with body:
      """
      { invalid: data }
      """
    Then the response status code should be 500