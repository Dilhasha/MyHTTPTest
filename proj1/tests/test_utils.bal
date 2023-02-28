// Returns a mock HTTP response to be used for the random joke API invocation.
function getMockResponse() returns json {
  json mockPayload = {"value":"When Chuck Norris wants an egg, he cracks open a chicken."};
  return mockPayload;
}

// Returns a mock response to be used for the category API invocation.
function getCategoriesResponse() returns json {
  return ["animal","food","history","money","movie"];
}