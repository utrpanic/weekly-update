
final class Reversort {
    
    var numbers: [Int]
    
    convenience init() {
        _ = readLine()
        self.init(input: readLine()!)
    }
    
    init(input: String) {
        self.numbers = input.split(separator: " ")
            .map { String($0) }
            .map { Int($0)! }
    }
    
    func output() -> String {
        var cost = 0
        for index in 0 ..< self.numbers.count - 1 {
            let minimumIndex = self.minimumIndex(from: index)
            self.reverse(from: index, to: minimumIndex)
            cost += minimumIndex - index + 1
        }
        return String(cost)
    }
    
    private func minimumIndex(from: Int) -> Int {
        var minimumIndex: Int = 0
        var minimumValue: Int = .max
        for index in from ..< self.numbers.count {
            if self.numbers[index] < minimumValue {
                minimumValue = self.numbers[index]
                minimumIndex = index
            }
        }
        return minimumIndex
    }
    
    private func reverse(from: Int, to: Int) {
        for index in 0 ... (to - from) {
            if index > (to - from) / 2 { continue }
            let temp = self.numbers[from + index]
            self.numbers[from + index] = self.numbers[to - index]
            self.numbers[to - index] = temp
        }
    }
}

let testCaseCount = Int(readLine()!)!
for index in 1 ... testCaseCount {
    let output = Reversort().output()
    print("Case #\(index): \(output)")
}

//let testCases: [(String, String)] = [
//    ("4 2 1 3", "6"),
//    ("1 2", "1"),
//    ("7 6 5 4 3 2 1", "12")
//
//]
//
//testCases.forEach { (input, expected) in
//    let result = Reversort(input: input).output()
//    print(result == expected ? "OK" : result)
//}
