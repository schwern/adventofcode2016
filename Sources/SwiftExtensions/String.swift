import Foundation

public extension String {
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
