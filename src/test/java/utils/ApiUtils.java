package utils;

import io.restassured.RestAssured;
import io.restassured.response.Response;

import static org.junit.Assert.assertEquals;

public class ApiUtils {

    private static final String BASE_URL = "https://jsonplaceholder.typicode.com";
    private static Response response;

    public static void sendRequest(String method, String path, String requestBody) {
        String endpoint = BASE_URL + path;

        switch (method.toUpperCase()) {
            case "GET":
                response = RestAssured.given()
                    .when()
                    .get(endpoint);
                printRequest("GET", endpoint, null);
                break;
            case "POST":
                response = RestAssured.given()
                    .header("Content-Type", "application/json")
                    .body(requestBody)
                    .when()
                    .post(endpoint);
                printRequest("POST", endpoint, requestBody);
                break;
            case "PUT":
                response = RestAssured.given()
                    .header("Content-Type", "application/json")
                    .body(requestBody)
                    .when()
                    .put(endpoint);
                printRequest("PUT", endpoint, requestBody);
                break;
            case "PATCH":
                response = RestAssured.given()
                    .header("Content-Type", "application/json")
                    .body(requestBody)
                    .when()
                    .patch(endpoint);
                printRequest("PATCH", endpoint, requestBody);
                break;
            case "DELETE":
                response = RestAssured.given()
                    .when()
                    .delete(endpoint);
                printRequest("DELETE", endpoint, null);
                break;
            default:
                throw new IllegalArgumentException("Unsupported HTTP method: " + method);
        }
        printResponse();
    }

    public static void assertStatusCode(int expected) {
        int actual = response.getStatusCode();
        assertEquals("Expected status code: " + expected + " but got: " + actual, expected, actual);
    }

    public static void assertJsonFieldEquals(String jsonPath, String expected) {
        Object actual = response.jsonPath().get(jsonPath);
    
        if (actual instanceof Integer) {
            assertEquals(Integer.valueOf(expected), actual);
        } else if (actual instanceof Boolean) {
            assertEquals(Boolean.valueOf(expected), actual);
        } else {
            assertEquals(expected, actual.toString());
        }
    }

    private static void printRequest(String method, String endpoint, String body) {
        System.out.println("Request: " + method + " " + endpoint);
        if (body != null) {
            System.out.println("Request Body: " + body);
        }
    }

    private static void printResponse() {
        System.out.println("Status Code: " + response.getStatusCode());
        // System.out.println("Response Body:\n" + response.getBody().asString());
    }
}