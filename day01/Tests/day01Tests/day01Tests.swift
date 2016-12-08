import XCTest
@testable import day01

class TestDay01 : XCTestCase {
    func testBlocksAway() {
        XCTAssertEqual( try blocksAway("R2, L3"), 5 )
        XCTAssertEqual( try blocksAway("R2, R2, R2"), 2)
        XCTAssertEqual( try blocksAway("R5, L5, R5, R3"), 12)
        XCTAssertEqual( try blocksAway("R5, L5, L5, L5"), 0)
        XCTAssertEqual( try blocksAway("R5, L5, L5, L5\n"), 0)
    }
}
