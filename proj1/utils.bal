import ballerina/io;

// This function checks if the provided category is a valid one.
function isCategoryAvailable(json[] categories, string category) returns boolean {
    foreach var cat in categories {
        if (cat.toString() == category) {
            return true;
        }
    }
    return false;
}

// Returns an error based on the HTTP response.
function createError(string responseCode) returns error {
    error err = error("error occurred while sending GET request");
    io:println(err.message(), ", status code: ", responseCode);
    return err;
}