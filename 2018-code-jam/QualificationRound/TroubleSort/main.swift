
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
        return "OK"
    }
}

typealias Solution = TroubleSort

func start() {
    let count = Int(readLine()!)!
    for index in 1 ... count {
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
        print("❗️ input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
})
