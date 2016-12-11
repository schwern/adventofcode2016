import Foundation
import Walker

let args = CommandLine.arguments
if args.count != 2 {
    print("Usage: \(args[0]) <filename>")
}
else {
    let file = args[1]
    let input = try String( contentsOfFile: file )

    var blocks = Walker().blocksAway(input)
    guard var crossing = Walker().firstCrossing(input) else {
        print("Couldn't find a crossing")
        exit(1)
    }
    var crossing_blocks = crossing.distance_from_origin()
    print( "It's \(blocks) blocks away." )
    print( "First crossing at \(crossing), which is \(crossing_blocks) away")
}
