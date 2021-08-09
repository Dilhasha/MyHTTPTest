import ballerina/http;

public final http:Client clientEndpoint = check getCurrentClient();

public isolated function getCurrentClient() returns http:Client|error {
     return new ("https://api.chucknorris.io/jokes/");
}


// public function getHttpClient() returns http:Client|http:ClientError {
//      return new ("https://api.chucknorris.io/jokes/");
// }