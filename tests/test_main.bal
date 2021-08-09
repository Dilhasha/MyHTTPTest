import ballerina/test;
import ballerina/http;
import ballerina/io;

public client class MockHttpClient {

remote function get(@untainted string path, map<string|string[]>? headers = (), http:TargetType targetType = http:Response) returns @tainted http:Response| http:PayloadType | http:ClientError {
    
        http:Response mockResponse = new;
        json mockPayload = {"value":"When Chuck Norris wants an egg, he cracks open a chicken."};
        mockResponse.setPayload(mockPayload);
        return mockResponse;
    }
}

@test:Mock {
    moduleName: "mymock.foo",
    functionName: "getAuthConfig"
}
function getMockAuthConfig() returns http:ClientConfiguration {
    return {
    auth: {
    }
};
}

 @test:Config {}
 function testGetRandomJoke() {
     string result = checkpanic getMyJoke("Sheldon");
     io:println(result);
     // Verify the return value.   
     test:assertEquals(result, "When Sheldon wants an egg, he cracks open a chicken.");
 }
  