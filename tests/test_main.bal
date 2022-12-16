import ballerina/test;
import ballerina/http;

@test:Mock {
    functionName: "intializeClient"
}
function getMockClient() returns http:Client|error {
    http:Client mockCl = test:mock(http:Client);
    test:prepare(mockCl).when("get")
        .thenReturnSequence(getCategoriesResponse(), getMockResponse());
    // test:prepare(mockCl).when("get").thenReturn(getMockResponse());

    // // Stub to return the specified mock response when the specified argument is passed.
    // test:prepare(mockCl).when("get").withArguments("/categories")
    //     .thenReturn(getCategoriesResponse());
    return mockCl;
}

@test:Config {}
public function testGetRandomJoke() returns error? {
    // Stub to return the specified mock response when the `get` function is called.

    // Invoke the function to test.
    string result = check getRandomJoke("Sheldon");

    // Verify the return value against the expected string.
    test:assertEquals(result, "When Sheldon wants an egg, he cracks open a chicken.");
}
