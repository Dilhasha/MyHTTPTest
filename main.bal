
import ballerina/io;
import ballerina/http;
import ballerina/regex;

const string CURRENT_NAMESPACE = "CURRENT_NAME_SPACE";
const string ALL_NAMESPACES = "*";

public type TokenIssuerConfiguration record {|
    string issuer = "https://localhost:9443/oauth2/token";
    string audience = "https://localhost:9443/oauth2/token";
    string keyId = "gateway_certificate_alias";
    decimal expTime = 3600;
|};


public type KeyStores record {|
    KeyStore signing;
    KeyStore tls;
|};

public type KeyStore record {|
    string path;
    string keyPassword?;
|};

public type K8sConfigurations record {|
    string host = "kubernetes.default";
    string serviceAccountPath = "serviceaccount";
    decimal readTimeout = 5;
|};

public type RuntimeConfiguratation record {|

    (string[] & readonly) serviceListingNamespaces = [ALL_NAMESPACES];
    string apiCreationNamespace = CURRENT_NAMESPACE;
    (TokenIssuerConfiguration & readonly) tokenIssuerConfiguration = {};
    KeyStores keyStores;
    (K8sConfigurations & readonly) k8sConfiguration = {};
|};

configurable RuntimeConfiguratation runtimeConfiguration = {
    keyStores: {
        signing: {
            path: "/home/wso2apk/runtime/security/wso2carbon.key"
        },
        tls: {
            path: "/home/wso2apk/runtime/security/wso2carbon.key"
        }
    }
};

const string K8S_API_ENDPOINT = "/api/v1";
final string token = check io:fileReadString(runtimeConfiguration.k8sConfiguration.serviceAccountPath + "/token");
final string caCertPath = runtimeConfiguration.k8sConfiguration.serviceAccountPath + "/ca.crt";
string namespaceFile = runtimeConfiguration.k8sConfiguration.serviceAccountPath + "/namespace";
string currentNameSpace = check io:fileReadString(namespaceFile);

final http:Client clientEndpoint = check intializeClient();

function intializeClient() returns http:Client|error {

    http:Client k8sApiClient = check new ("https://" + runtimeConfiguration.k8sConfiguration.host,
    auth = {
        token: token
    },
        secureSocket = {
        cert: caCertPath

    }
    );
    return k8sApiClient;
//    return new ("https://api.chucknorris.io/jokes/");
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