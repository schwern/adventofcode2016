import Foundation

enum WalkerError: Error {
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

    init( _ x: Int, _ y: Int ) {
        self.x = x
        self.y = y
    }

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
    var pos = GridPoint(0,0)
    var facing = 0

    func newPos( _ direction: String ) throws -> GridPoint {
        let turn = direction[direction.startIndex]
        guard let distance = Int(String(direction.characters.dropFirst())) else {
            throw WalkerError.invalidDirection( direction: direction )
        }

        switch(turn) {
        case "R":
            facing += 1
        case "L":
            facing += 3
        default:
            throw WalkerError.invalidDirection( direction: direction)
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
            throw WalkerError.invalidFacing(facing: facing)
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

    func _path( from: GridPoint, to: GridPoint ) -> [GridPoint] {
        var here = from
        var path : [GridPoint] = [here]
        let x_diff = to.x - from.x
        let y_diff = to.y - from.y
        let x_sign = x_diff >= 0 ? 1 : -1
        let y_sign = y_diff >= 0 ? 1 : -1

        if( x_diff != 0 ) {
            for _ in 1..<abs(x_diff) {
                here.x += x_sign
                path.append(here)
            }
        }
        if( y_diff != 0 ) {
            for _ in 1..<abs(y_diff) {
                here.y += y_sign
                path.append(here)
            }
        }

        return path
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

    func firstCrossing( _ directions: String ) -> GridPoint? {
        var visited : Set<GridPoint> = []
        for direction in splitDirections( directions ) {
            let from = pos
            move(direction)
            let to = pos
            let path = _path(from: from, to: to)
            for spot in path {
                if visited.contains(spot) {
                    return spot
                }

                visited.insert(spot)
            }
        }

        return nil
    }
}
