import ballerina/http;

configurable boolean testMode = false; 
configurable string clientURL = "https://api.chucknorris.io/jokes/";
public final http:Client clientEndpoint = check new (clientURL, getAuthConfig());

public function getCurrentClient() returns http:Client {
     return clientEndpoint;
}
public function getAuthConfig() returns http:ClientConfiguration {
     if(testMode){
          return {
               auth: {}
          };
     } else{
          return {
               auth: {
                    tokenUrl: "http://localhost:9095/test/token",
                    clientId: "clid124",
                    clientSecret: "clsc972",
                    optionalParams: {}
               }
          };
     }
}

