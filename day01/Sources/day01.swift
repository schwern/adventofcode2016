import Foundation

enum BlocksError: Error {
case invalidDirection( direction: String )
case invalidFacing( facing: Int )
}

extension String {
    func trim( _ toTrim :CharacterSet = CharacterSet.whitespacesAndNewlines ) -> String {
        return self.trimmingCharacters( in: toTrim )
    }

    mutating func chomp() {
        let lastIdx = index(before: endIndex)
        if self[lastIdx] == "\n" {
            return self.removeSubrange(lastIdx...lastIdx)
        }
    }
}

struct GridPoint :Hashable {
    var x: Int
    var y: Int

    var hashValue: Int {
        return x.hashValue ^ y.hashValue
    }

    func distance_from_origin() -> Int {
        return abs(x) + abs(y)
    }

    static func == (lhs: GridPoint, rhs: GridPoint) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

class Walker {
    var pos = GridPoint(x:0,y:0)
    var facing = 0

    func newPos( _ direction: String ) throws -> GridPoint {
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

        var new_pos = pos
        switch(facing % 4) {
        case 0:
            new_pos.y += distance
        case 1:
            new_pos.x += distance
        case 2:
            new_pos.y -= distance
        case 3:
            new_pos.x -= distance
        default:
            throw BlocksError.invalidFacing(facing: facing)
        }

        return new_pos
    }

    func move( _ direction: String ) {
        do {
            pos = try newPos(direction)
        }
        catch {
            print("Didn't understand \(direction), ignoring")
        }
    }

    func splitDirections( _ directions: String ) -> [String] {
        return directions.components(separatedBy: ", ").map { $0.trim() }
    }

    func blocksAway( _ directions: String ) -> Int {
        for direction in splitDirections( directions ) {
            move(direction)
        }

        return pos.distance_from_origin()
    }
}
