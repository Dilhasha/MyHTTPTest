import ballerina/test;
import ballerina/http;
import ballerina/io;
import mymock.foo as _;

public client class MockHttpClient {

remote function get(@untainted string path, map<string|string[]>? headers = (), http:TargetType targetType = http:Response) returns @tainted http:Response| http:PayloadType | http:ClientError {
    
        http:Response mockResponse = new;
        json mockPayload = {"value":"When Chuck Norris wants an egg, he cracks open a chicken."};
        mockResponse.setPayload(mockPayload);
        return mockResponse;
    }
}

// @test:Mock {
//     moduleName: "mymock.foo",
//     functionName: "getHttpClient"
// }
// function getMockClient() returns http:Client {
//     http:Client mockCl = <http:Client>test:mock(http:Client, new MockHttpClient());
//     return mockCl;
// }

@test:Mock {
    moduleName: "mymock.foo",
    functionName: "getCurrentClient"
}
isolated function getCurrentClient() returns http:Client {
    http:Client mockCl = <http:Client>test:mock(http:Client, new MockHttpClient());
    return mockCl;
}
 @test:Config {}
 function testGetRandomJoke() {
     string result = checkpanic getMyJoke("Sheldon");
     io:println(result);
     // Verify the return value.   
     test:assertEquals(result, "When Sheldon wants an egg, he cracks open a chicken.");
 }
  