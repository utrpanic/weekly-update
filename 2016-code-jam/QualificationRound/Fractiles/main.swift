
class Fractiles {
    
    init(input: String) {
        
    }
    
    convenience init() {
        let input = readLine()!
        self.init(input: input)
    }
    
    func output() -> String {
        return "2"
    }
}

typealias Solution = Fractiles

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
    Test(input: "2 3 2", expected: "2"),
    Test(input: "1 1 1", expected: "1"),
    Test(input: "2 1 1", expected: "IMPOSSIBLE"),
    Test(input: "2 1 2", expected: "1 2"),
    Test(input: "3 2 3", expected: "2 6"),
]

tests.forEach {
    let output = Solution(input: $0.input).output()
    if $0.expected == output {
        print("✅ input: \($0.input), output: \(output)")
    } else {
        print("❗️ input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
}
