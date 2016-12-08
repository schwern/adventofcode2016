import Foundation

enum BlocksError: Error {
case invalidDirection( direction: String )
case invalidFacing( facing: Int )
}

func blocksAway( _ directions: String ) throws -> Int {
    var x = 0
    var y = 0
    var facing = 0
    for _direction in directions.components(separatedBy: ", ") {
        let direction = _direction.trimmingCharacters(
            in: CharacterSet.whitespacesAndNewlines
        )
        let turn = direction[direction.startIndex]
        guard let distance = Int(String(direction.characters.dropFirst())) else {
            throw BlocksError.invalidDirection( direction: direction )
        }

        switch(turn) {
        case "R":
            facing += 1
        case "L":
            facing += 3
        default:
            throw BlocksError.invalidDirection( direction: direction)
        }

        switch(facing % 4) {
        case 0:
            y += distance
        case 1:
            x += distance
        case 2:
            y -= distance
        case 3:
            x -= distance
        default:
            throw BlocksError.invalidFacing(facing: facing)
        }
    }

    return abs(x) + abs(y)
}
