import ballerina/http;

public final http:Client clientEndpoint = check new ("https://api.chucknorris.io/jokes/", getAuthConfig());

public function getAuthConfig() returns http:ClientConfiguration {
    return {
    auth: {
        tokenUrl: "http://localhost:9095/test/token",
        clientId: "clid124",
        clientSecret: "clsc972",
        optionalParams: {}
    }
};
}

