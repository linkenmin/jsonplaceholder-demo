
package steps;

import io.cucumber.java.en.When;
import utils.ApiUtils;
import io.cucumber.java.en.Then;

public class CommonSteps {

    @When("I send a {string} request to {string} with body:")
    public void sendRequest(String method, String path, String requestBody) {
        ApiUtils.sendRequest(method, path, requestBody);
    }

    @Then("the response status code should be {int}")
    public void verifyResponseStatusCode(int expectedStatusCode) {
        ApiUtils.assertStatusCode(expectedStatusCode);
    }

    @Then("the response JSON path {string} should be {string}")
    public void verifyResponseJsonPath(String jsonPath, String expectedValue) {
        ApiUtils.assertJsonFieldEquals(jsonPath, expectedValue);
    }
}
