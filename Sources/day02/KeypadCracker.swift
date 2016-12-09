import Foundation
import SwiftExtensions
import GridPoint

class KeypadCracker {
    enum KeypadCrackerErrors : Error {
        case invalidInstruction( instruction: String )
        case invalidMove( move: Character )
    }

    var keypad : [[Character]] = [
        [" ",  " ",  "1",  " ",  " "],
        [" ",  "2",  "3",  "4",  " "],
        ["5",  "6",  "7",  "8",  "9"],
        [" ",  "A",  "B",  "C",  " "],
        [" ",  " ",  "D",  " ",  " "]
    ]

    var finger = GridPoint(2,0)

    func figureCode( _ instructions: [String] ) -> String {
        var code = ""
        for instruction in instructions {
            if( instruction.isEmpty ) {
                continue
            }
            code.append(try! figureInstruction(instruction.trim()))
        }
        return code
    }

    func figureInstruction( _ instruction: String ) throws -> Character {
        for move in instruction.characters {
            do {
                try moveFinger(move)
            }
            catch {
                throw KeypadCrackerErrors.invalidInstruction( instruction: instruction )
            }
        }

        return keypad[finger.x][finger.y]
    }

    func moveFinger( _ move : Character ) throws {
        var x = finger.x
        var y = finger.y

        switch(move) {
        case "U":
            x -= 1
        case "D":
            x += 1
        case "R":
            y += 1
        case "L":
            y -= 1
        default:
            throw KeypadCrackerErrors.invalidMove( move: move )
        }

        let keypadXRange = 0..<keypad.endIndex
        let keypadYRange = 0..<keypad[0].endIndex
        if( keypadXRange.contains(x) &&
            keypadYRange.contains(y) &&
            keypad[x][y] != " ")
        {
            finger.x = x
            finger.y = y
        }
    }
}
