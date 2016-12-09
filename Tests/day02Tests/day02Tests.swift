import XCTest
@testable import day02

class TestDay02 : XCTestCase {
    func testFigureCode() {
        let instructions = [
            "ULL",
            "RRDDD\n",
            "LURDL",
            "UUUUD"
        ];

        let cracker = KeypadCracker()
        XCTAssertEqual( cracker.figureCode(instructions), 1985 )
    }

    func testTryVerticalMove() {
        let cracker = KeypadCracker()
        XCTAssertEqual( cracker.tryVerticalMove("U"), 2)
        cracker.finger = 2
        XCTAssertEqual( cracker.tryVerticalMove("U"), 2)

        cracker.finger = 5
        XCTAssertEqual( cracker.tryVerticalMove("D"), 8)
        cracker.finger = 8
        XCTAssertEqual( cracker.tryVerticalMove("D"), 8)
    }

    func testTryHorizontalMove() {
        let cracker = KeypadCracker()
        XCTAssertEqual( cracker.tryHorizontalMove("R"), 6)
        cracker.finger = 6
        XCTAssertEqual( cracker.tryHorizontalMove("R"), 6)

        cracker.finger = 5
        XCTAssertEqual( cracker.tryHorizontalMove("L"), 4)
        cracker.finger = 4
        XCTAssertEqual( cracker.tryHorizontalMove("L"), 4)
    }
}
