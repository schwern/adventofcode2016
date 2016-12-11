import PackageDescription

let package = Package(
    name: "AdventOfCode",
    targets: [
        Target(name: "day01", dependencies: ["Walker"]),
        Target(name: "day02", dependencies: ["KeypadCracker"]),
        Target(name: "KeypadCracker", dependencies: ["SwiftExtensions", "GridPoint"]),
        Target(name: "Walker", dependencies: ["SwiftExtensions", "GridPoint"]),
    ]
)
