@Posts
Feature: Testing the /posts API

  @FunctionalTest
  Scenario: Get all posts
    When I send a "GET" request to "/posts" with body:
      """
      {}
      """
    Then the response status code should be 200

  @FunctionalTest
  Scenario: Create a new post
    When I send a "POST" request to "/posts" with body:
      """
      {
        "userId": 11,
        "id": 101,
        "title": "mytitle",
        "body": "mybody"
      }
      """
    Then the response status code should be 201
    And the response JSON path "id" should be "101"

  @FunctionalTest
  Scenario: Update an existing post
    When I send a "PUT" request to "/posts/1" with body:
      """
      {
        "userId": 11,
        "id": 101,
        "title": "mytitle",
        "body": "mybody"
      }
      """
    Then the response status code should be 200
    And the response JSON path "userId" should be "11"
    And the response JSON path "id" should be "1"
    And the response JSON path "title" should be "mytitle"
    And the response JSON path "body" should be "mybody"

  @FunctionalTest
  Scenario: Partially update an existing post
    When I send a "PATCH" request to "/posts/1" with body:
      """
      {
        "body": "mybody"
      }
      """
    Then the response status code should be 200
    And the response JSON path "body" should be "mybody"

  @FunctionalTest
  Scenario: Delete an existing post
    When I send a "DELETE" request to "/posts/1" with body:
      """
      {}
      """
    Then the response status code should be 200

  @NegativeTest
  Scenario: Get a nonexistent post
    When I send a "GET" request to "/posts/101" with body:
      """
      {}
      """
    Then the response status code should be 404

  @NegativeTest
  Scenario: Send invalid POST data
    When I send a "POST" request to "/posts" with body:
      """
      { invalid: data }
      """
    Then the response status code should be 500