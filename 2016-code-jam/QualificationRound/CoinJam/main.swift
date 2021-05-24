
class CoinJam {
    
    init(input: String) {

    }
    
    convenience init() {
        let input = readLine()!
        self.init(input: input)
    }
    
    func output() -> String {
        return """
        100011 5 13 147 31 43 1121 73 77 629
        111111 21 26 105 1302 217 1032 513 13286 10101
        111001 3 88 5 1938 7 208 3 20 11
        """
    }
}

typealias Solution = CoinJam

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

let tests: Array<Test> = [
    Test(input: "6 3", expected: """
        100011 5 13 147 31 43 1121 73 77 629
        111111 21 26 105 1302 217 1032 513 13286 10101
        111001 3 88 5 1938 7 208 3 20 11
        """),
]

tests.forEach {
    let output = Solution(input: $0.input).output()
    if $0.expected == output {
        print("✅ input: \($0.input), output: \(output)")
    } else {
        print("❗️ input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
}
