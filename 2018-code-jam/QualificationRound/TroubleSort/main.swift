
class TroubleSort {
    
    var numbers: [Int]
    
    init(input: String) {
        self.numbers = input.split(separator: " ").map { Int($0)! }
    }
    
    func output() -> String {
        var previous: [Int]
        repeat {
            previous = self.numbers
            self.trouble()
        } while previous != self.numbers
        if let index = self.unsortedIndex() {
            return String(index)
        } else {
            return "OK"
        }
    }
    
    private func trouble() {
        for index in 0 ..< (self.numbers.count - 2) {
            if self.numbers[index] > self.numbers[index+2] {
                let temp = self.numbers[index]
                self.numbers[index] = self.numbers[index+2]
                self.numbers[index+2] = temp
            }
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
        _ = readLine()
        let input = readLine()!
        let solution = Solution(input: input)
        print("Case #\(index): \(solution.output())")
    }
}

//start()

struct Test {
    var input: String
    var expected: String
}

let tests: Array<Test> = [
    Test(input: "5 6 8 4 3", expected: "OK"),
    Test(input: "8 9 7", expected: "1"),
]

tests.forEach({
    let output = Solution(input: $0.input).output()
    if $0.expected == output {
        print("✅ input: \($0.input), output: \(output)")
    } else {
        print("❗️ input: \($0.input), expected: \($0.expected), but: \(output)")
    }
})
