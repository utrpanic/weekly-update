class Solution {
    
    func start() {
        let count = Int(readLine() ?? "")!
        for index in 1 ... count {
            let number = readLine()!
            let result = self.splitNumberExcept4(number)
            print("Case #\(index): \(result)")
        }
    }
    
    func splitNumberExcept4(_ number: String) -> String {
        var large = ""
        var small = ""
        for index in 0 ..< number.count {
            let character = number.charAt(index)
            if character == "4" {
                large.append("3")
                small.append("1")
            } else {
                large.append(character)
                if !small.isEmpty {
                    small.append("0")
                }
            }
        }
        return "\(large) \(small)"
    }
}

Solution().start()

private extension String {
    
    func charAt(_ index: Int) -> Character {
        let stringIndex = self.index(self.startIndex, offsetBy: index)
        return self[stringIndex]
    }
}
