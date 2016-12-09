import XCTest

@testable import day01

class TestStringExtensions : XCTestCase {
    func testChomp() {
        let tests = [
            "foo": "foo",
            "foo ": "foo ",
            "foo \n": "foo ",
            "\nfoo \n": "\nfoo ",
            "": "",
        ]

        for (_have, want) in tests {
            var have = _have
            have.chomp()
            XCTAssertEqual( have, want )
        }
    }

    func testTrim() {
        let tests = [
            "": "",
            "   ": "",
            " foo ": "foo",
            "\t f o o \n": "f o o"
        ]

        for (have, want) in tests {
            XCTAssertEqual( have.trim(), want )
        }
    }
}
