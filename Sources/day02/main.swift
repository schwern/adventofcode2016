import Foundation

let cracker = KeypadCracker()
let args = CommandLine.arguments
if args.count != 2 {
    print("Usage: \(args[0]) <filename>")
}
else {
    let file = args[1]
    let input = try String( contentsOfFile: file )

    let code = cracker.figureCode( input.components(separatedBy: "\n") )
    print("The code is \(code)")
}
