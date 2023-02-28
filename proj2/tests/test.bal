import ballerina/test;
import dilhashanazeer/proj1;

@test:Config {}
public function testSum() returns error? {
    test:assertEquals(proj1:addInt(1, 2), 3);
}

