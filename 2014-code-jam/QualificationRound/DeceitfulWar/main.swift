
class DeceitfulWar {
    
    convenience init() {
        _ = readLine()
        self.init(input: readLine()!)
    }
    
    init(input: String) {
        
    }
    
    func output() -> String {
        return "0 0"
    }
}

typealias Solution = DeceitfulWar

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
    Test(input: """
        1
        0.5
        0.6
        """, expected: "0 0"),
    Test(input: """
        2
        0.7 0.2
        0.8 0.3
        """, expected: "1 0"),
    Test(input: """
        3
        0.5 0.1 0.9
        0.6 0.4 0.3
        """, expected: "2 1"),
    Test(input: """
        9
        0.186 0.389 0.907 0.832 0.959 0.557 0.300 0.992 0.899
        0.916 0.728 0.271 0.520 0.700 0.521 0.215 0.341 0.458
        """, expected: "8 4"),
]

tests.forEach({
    let output = Solution(input: $0.input).output()
    if $0.expected == output {
        print("✅ input: \($0.input), output: \(output)")
    } else {
        print("❗️ input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
})
