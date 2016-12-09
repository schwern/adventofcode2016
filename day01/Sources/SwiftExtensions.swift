import Foundation

extension String {
    func trim( _ toTrim :CharacterSet = CharacterSet.whitespacesAndNewlines ) -> String {
        return self.trimmingCharacters( in: toTrim )
    }

    mutating func chomp() {
        if( self.isEmpty ) {
            return
        }

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
