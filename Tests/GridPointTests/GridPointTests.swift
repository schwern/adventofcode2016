import XCTest
@testable import GridPoint

class TestGridPoint : XCTestCase {
    func testDistanceFromOrigin() {
        let point = GridPoint(3,-4)
        XCTAssertEqual( point.distance_from_origin(), 7)
    }
}
