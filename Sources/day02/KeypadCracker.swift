import Foundation
import SwiftExtensions

class KeypadCracker {
    enum KeypadCrackerErrors : Error {
    case invalidInstruction( instruction: String )
    }

    let keypadRange = 1...9;
    let verticalMoves : [Character:Int] = [
        "U": -3,
        "D": 3,
    ]
    var finger = 5

    func figureCode( _ instructions: [String] ) -> Int {
        var code = 0
        for instruction in instructions {
            code *= 10
            code += try! figureInstruction(instruction.trim())
        }
        return code
    }

    func figureInstruction( _ instruction: String ) throws -> Int {
        for move in instruction.characters {
            var key = tryVerticalMove(move)
            if key == nil {
                key = tryHorizontalMove(move)
            }
            if key == nil {
                throw KeypadCrackerErrors.invalidInstruction( instruction: instruction )
            }

            finger = key!
        }

        return finger
    }

    func tryVerticalMove( _ move : Character ) -> Int? {
        guard let moveAsInt = verticalMoves[move] else {
            return nil;
        }

        let key = finger + moveAsInt;

        return keypadRange.contains(key) ? key : finger
    }

    func tryHorizontalMove( _ move : Character ) -> Int? {
        switch(move) {
            case "R":
                if( finger % 3 == 0 ) {
                    return finger
                }
                else {
                    return finger + 1
                }
            case "L":
                if( finger % 3 == 1 ) {
                    return finger
                }
                else {
                    return finger - 1
                }
            default:
                return nil
        }
    }
}
