class Solution {
    
    func start() {
        let count = Int(readLine() ?? "")!
        for index in 1 ... count {
            let number = Int(readLine() ?? "")!
            let result = self.splitNumberExcept4(number)
            print("Case #\(index): \(result)")
        }
    }
    
    func splitNumberExcept4(_ number: Int) -> String {
        let string = String(number)
        var smallNumber = 0
        for (index, char) in string.reversed().enumerated() {
            if char == "4" {
                smallNumber += self.pow10(with: index)
            }
        }
        return "\(number - smallNumber) \(smallNumber)"
    }
    
    func pow10(with number: Int) -> Int {
        var number = number
        var result = 1;
        while number > 0 {
            result *= 10
            number -= 1
        }
        return result
    }
}

Solution().start()
