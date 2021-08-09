import mymock.foo;
import ballerina/regex;
import ballerina/io;
import ballerina/http;

  // This function performs a `get` request to the Chuck Norris API and returns a random joke 
 // with the name replaced by the provided name or an error if the API invocation fails.
 public function getRandomJoke(string name) returns @tainted string|error {
     http:Response response = check foo:clientEndpoint ->get("/random");
     if (response.statusCode == http:STATUS_OK) {
         var payload = response.getJsonPayload();
         if (payload is json) {
             json joke = check payload.value;
             string replacedText = regex:replaceAll(joke.toString(), "Chuck Norris", name);
             return replacedText;
         }
     } else {
         error err = error("error occurred while sending GET request");
         io:println(err.message(), ", status code: ", response.statusCode, ", reason: ", response.getJsonPayload());
         return err;
     }

     error err = error("error occurred while sending GET request");
     return err;
 }