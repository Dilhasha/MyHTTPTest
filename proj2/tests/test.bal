import ballerina/test;

@test:Config {}
public function testSum() returns error? {
    test:assertEquals(sum(1, 2), 3);
}

public function testSum2() returns error? {
    test:assertEquals(sum2(1, 2), 3);

}
