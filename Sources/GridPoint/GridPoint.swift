public struct GridPoint :Hashable {
    public var x: Int
    public var y: Int

    public init( _ x: Int, _ y: Int ) {
        self.x = x
        self.y = y
    }

    public var hashValue: Int {
        return x.hashValue ^ y.hashValue
    }

    public func distance_from_origin() -> Int {
        return abs(x) + abs(y)
    }

    static public func == (lhs: GridPoint, rhs: GridPoint) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
