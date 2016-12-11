import Foundation
import SwiftExtensions
import GridPoint

enum WalkerError: Error {
    case invalidDirection( direction: String )
    case invalidFacing( facing: Int )
}

public class Walker {
    var pos = GridPoint(0,0)
    var facing = 0

    public init() {}

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

    public func blocksAway( _ directions: String ) -> Int {
        for direction in splitDirections( directions ) {
            move(direction)
        }

        return pos.distance_from_origin()
    }

    public func firstCrossing( _ directions: String ) -> GridPoint? {
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
