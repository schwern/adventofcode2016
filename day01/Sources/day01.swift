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

    func move( _ direction: String ) throws {
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
            pos.y += distance
        case 1:
            pos.x += distance
        case 2:
            pos.y -= distance
        case 3:
            pos.x -= distance
        default:
            throw BlocksError.invalidFacing(facing: facing)
        }
    }

    func splitDirections( _ directions: String ) -> [String] {
        return directions.components(separatedBy: ", ").map { $0.trim() }
    }

    func blocksAway( _ directions: String ) -> Int {
        for direction in splitDirections( directions ) {
            do {
                try move(direction)
            }
            catch {
                print("Didn't understand \(direction), ignoring")
            }
        }

        return pos.distance_from_origin()
    }
}
