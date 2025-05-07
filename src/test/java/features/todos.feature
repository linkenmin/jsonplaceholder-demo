@Todos
Feature: Testing the /todos API

  @FunctionalTest
  Scenario: Get all todos
    When I send a "GET" request to "/todos" with body:
      """
      {}
      """
    Then the response status code should be 200

  @FunctionalTest
  Scenario: Create a new todo
    When I send a "POST" request to "/todos" with body:
      """
      {
        "userId": 11,
        "id": 201,
        "title": "mytitle",
        "completed": false
      }
      """
    Then the response status code should be 201
    And the response JSON path "id" should be "201"

  @FunctionalTest
  Scenario: Update an existing post
    When I send a "PUT" request to "/todos/1" with body:
      """
      {
        "userId": 11,
        "id": 201,
        "title": "mytitle",
        "completed": false
      }
      """
    Then the response status code should be 200
    And the response JSON path "userId" should be "11"
    And the response JSON path "id" should be "1"
    And the response JSON path "title" should be "mytitle"
    And the response JSON path "completed" should be "false"

  @FunctionalTest
  Scenario: Partially update an existing post
    When I send a "PATCH" request to "/todos/1" with body:
      """
      {
        "title": "mytitle"
      }
      """
    Then the response status code should be 200
    And the response JSON path "title" should be "mytitle"

  @FunctionalTest
  Scenario: Delete an existing post
    When I send a "DELETE" request to "/todos/1" with body:
      """
      {}
      """
    Then the response status code should be 200

  @NegativeTest
  Scenario: Get a nonexistent todo
    When I send a "GET" request to "/todos/201" with body:
      """
      {}
      """
    Then the response status code should be 404

  @NegativeTest
  Scenario: Send invalid POST data for todo
    When I send a "POST" request to "/todos" with body:
      """
      { invalid: data }
      """
    Then the response status code should be 500