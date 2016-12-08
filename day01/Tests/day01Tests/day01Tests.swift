import XCTest
@testable import day01

class TestDay01 : XCTestCase {
    func testBlocksAway() {
        let tests = [
            "R2, L3": 5,
            "R2, R2, R2": 2,
            "R5, L5, R5, R3": 12,
            "R5, L5, L5, L5": 0,
            "R5, L5, L5, L5\n": 0,
        ]

        for (have, want) in tests {
            let walker = Walker()
            XCTAssertEqual( walker.blocksAway(have), want )
        }
    }

    func testPath() {
        let walker = Walker()
        XCTAssertEqual(
            walker._path(from: GridPoint(0,0), to: GridPoint(0,3) ),
            [GridPoint(0,0), GridPoint(0,1), GridPoint(0,2)]
        )
        XCTAssertEqual(
            walker._path(from: GridPoint(-1,3), to: GridPoint(-1,1) ),
            [GridPoint(-1,3), GridPoint(-1,2)]
        )
    }
}
