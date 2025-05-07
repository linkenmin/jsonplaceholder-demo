# jsonplaceholder-demo

This project demonstrates API testing using **Java**, **Cucumber**, and **Rest Assured** with the **JSONPlaceholder** API https://jsonplaceholder.typicode.com/. The goal of this project is to provide a clean, modular approach to testing various HTTP methods (GET, POST, PUT, PATCH, DELETE) while maintaining a clear, extensible structure.

## Design Philosophy

1. **Generic HTTP Methods for Request Handling**  
   The project uses generic methods to send HTTP requests, ensuring flexibility and reusability. This approach simplifies the process of making requests and can easily be extended for other APIs.

2. **Categorized Feature Files**  
   The `.feature` files are organized based on the API endpoints provided by JSONPlaceholder. Each endpoint has corresponding tests, including:
   - **Functional Tests**: Verifying correct behavior of each endpoint for valid inputs.
   - **Negative Tests**: Ensuring that error handling works as expected for invalid inputs and edge cases.

3. **Future Improvements (TODO Backlog)**  
   - Enhance logging functionality to integrate clean, readable reports in CI/CD pipelines.

## Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/linkenmin/jsonplaceholder-demo.git
   ```

2. **Install dependencies:**

   Ensure that you have **Maven** and **Java** installed.
   Run the following command to install the required dependencies:

   ```bash
   mvn install
   ```

## Run the Tests

1. **Run all tests:**

   This will run all the tests in your project.

   ```bash
   mvn test
   ```

2. **Run tests by tag:**

   - Only run tests related to the `Posts` API:

     ```bash
     mvn test -Dcucumber.filter.tags="@Posts"
     ```

   - Only run functional test cases:

     ```bash
     mvn test -Dcucumber.filter.tags="@FunctionalTest"
     ```

## Docker Integration

This project includes a `Dockerfile` to easily build and run your tests inside a lightweight Docker container. It uses a **multi-stage build** based on **Maven 3.8.4 with OpenJDK 17 (slim variant)**.

If you're building on an **ARM64-based machine** (like Apple Silicon), it's recommended to use `buildx` with the `--platform=linux/amd64` option to create an **AMD64-compatible image**:

```
docker buildx build --platform=linux/amd64 ...
```

This ensures the final image is not only significantly smaller in size, but also compatible with cloud CI/CD environments like **AWS CodeBuild**, which often expect AMD64 images by default.

If you're already on an AMD64 machine, you can build the image directly without using `buildx`.

## Project Structure

```
src/
├── main/                                # Typically for production code, but this project focuses on tests
└── test/
    └── java/
        ├── features/
        │   ├── albums.feature           # Test cases for albums API
        │   ├── comments.feature         # Test cases for comments API
        │   ├── photos.feature           # Test cases for photos API
        │   ├── posts.feature            # Test cases for posts API
        │   ├── todos.feature            # Test cases for todos API
        │   └── users.feature            # Test cases for users API
        ├── runners/
        │   └── TestRunner.java          # Main entry point for running Cucumber tests
        ├── steps/
        │   └── CommonSteps.java         # Shared step definitions across APIs
        └── utils/
            └── ApiUtils.java            # Utility methods for sending HTTP requests
```
