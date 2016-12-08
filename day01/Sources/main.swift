import Foundation

let args = CommandLine.arguments
if args.count != 2 {
    print("Usage: \(args[0]) <filename>")
}
else {
    let file = args[1]
    let input = try String( contentsOfFile: file )
    var walker = Walker()
    print( walker.blocksAway( input ))
}
