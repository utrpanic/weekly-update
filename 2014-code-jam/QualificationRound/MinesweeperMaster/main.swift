
class MinesweeperMaster {
    
    convenience init() {
        self.init(input: readLine()!)
    }
    
    init(input: String) {
        
    }
    
    func output() -> String {
        return "Impossible"
    }
}

typealias Solution = MinesweeperMaster

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
    Test(input: "5 5 23", expected: """
        Impossible
        """),
    Test(input: "3 1 1", expected: """
        c
        .
        *
        """),
    Test(input: "2 2 1", expected: """
        Impossible
        """),
    Test(input: "4 7 3", expected: """
        ......*
        .c....*
        .......
        ..*....
        """),
    Test(input: "10 10 82", expected: """
        **********
        **********
        **********
        ****....**
        ***.....**
        ***.c...**
        ***....***
        **********
        **********
        **********
        """),
]

tests.forEach({
    let output = Solution(input: $0.input).output()
    if $0.expected == output {
        print("✅ input: \($0.input), output: \(output)")
    } else {
        print("❗️ input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
})
