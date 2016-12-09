import XCTest
import GridPoint
@testable import day02

class TestKeypadCracker : XCTestCase {
    let instructions = [
        "ULL",
        "RRDDD\n",
        "LURDL",
        "UUUUD"
    ];

    func testFigureCodePart1() {
        let cracker = KeypadCracker()
        cracker.keypad = [
            ["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"]
        ]
        cracker.finger = GridPoint(1,1)
        XCTAssertEqual( cracker.figureCode(instructions), "1985" )
    }

    func testFigureCodePart2() {
        let cracker = KeypadCracker()
        XCTAssertEqual( cracker.figureCode(instructions), "5DB3" )
    }
}
