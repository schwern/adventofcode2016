import PackageDescription

let package = Package(
    name: "AdventOfCode",
    targets: [
        Target(name: "day01", dependencies: ["SwiftExtensions", "GridPoint"])
    ]
)
