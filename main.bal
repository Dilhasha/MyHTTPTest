import mymock.bar;


  // This function performs a `get` request to the Chuck Norris API and returns a random joke 
 // with the name replaced by the provided name or an error if the API invocation fails.
function getMyJoke(string name) returns @tainted string|error {
    return checkpanic bar:getRandomJoke("Sheldon");
 }
