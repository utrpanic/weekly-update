
class TroubleSort {
    
    var numbers: [Int]
    
    convenience init() {
        _ = readLine()
        self.init(input: readLine()!)
    }
    
    init(input: String) {
        self.numbers = input.split(separator: " ").map { Int($0)! }
    }
    
    func output() -> String {
        var evens = [Int]()
        var odds = [Int]()
        for index in 0 ..< self.numbers.count {
            if index % 2 == 0 {
                evens.append(self.numbers[index])
            } else {
                odds.append(self.numbers[index])
            }
        }
        evens.sort()
        odds.sort()
        for index in 0 ..< self.numbers.count {
            if index % 2 == 0 {
                self.numbers[index] = evens[index/2]
            } else {
                self.numbers[index] = odds[index/2]
            }
        }
        if let unsortedIndex = self.unsortedIndex() {
            return String(unsortedIndex)
        } else {
            return "OK"
        }
    }
    
    private func unsortedIndex() -> Int? {
        for index in 0 ..< (self.numbers.count - 1) {
            if self.numbers[index] > self.numbers[index+1] {
                return index
            }
        }
        return nil
    }
}

typealias Solution = TroubleSort

func start() {
    let count = Int(readLine()!)!
    for index in 1 ... count {
        let solution = Solution()
        print("Case #\(index): \(solution.output())")
    }
}

//start()

struct Test {
    var input: String
    var expected: String
}

//let largeInput = (0 ..< 100000).map { String($0) }.joined(separator: " ")
let tests: Array<Test> = [
    Test(input: "5 6 8 4 3", expected: "OK"),
    Test(input: "8 9 7", expected: "1"),
    Test(input: "5 4 3 2 1", expected: "OK"),
    Test(input: "6 5 4 3 2 1", expected: "0"),
//    Test(input: largeInput, expected: "OK")
]

tests.forEach({
    let output = Solution(input: $0.input).output()
    if $0.expected == output {
        print("✅ input: \($0.input), output: \(output)")
    } else {
        print("❗️ input: \($0.input), expected: \($0.expected), but: \(output)")
    }
})
