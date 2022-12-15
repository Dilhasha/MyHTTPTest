
import ballerina/io;
import ballerina/http;
import ballerina/regex;

final http:Client clientEndpoint = check intializeClient();

function intializeClient() returns http:Client|error {
   return new ("https://api.chucknorris.io/jokes/");
}

// This function performs a `get` request to the Chuck Norris API and returns a random joke 
// or an error if the API invocations fail.
function getRandomJoke(string name, string category = "food") returns @tainted string|error {
    string replacedText = "";
    json response = check clientEndpoint->get("/categories", targetType = json);

    // Check if the provided category is available

        json[] categories = check response.ensureType();

        if (!isCategoryAvailable(categories, category)) {
            error err = error("'" + category + "' is not a valid category.");
            io:println(err.message());
            return err;
        }


    // Get a random joke from the provided category
    response = check clientEndpoint->get("/random?category=" + category);

        json payload = response;
        json joke = check payload.value;

        replacedText = regex:replaceAll(joke.toString(), "Chuck Norris", name);
        return replacedText;

}