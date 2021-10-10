final class CodyJamal {
    
    var cjCost: Int
    var jcCost: Int
    var mural: [Character]
    
    convenience init() {
        self.init(input: readLine()!)
    }
    
    init(input: String) {
        let inputs = input.split(separator: " ").map(String.init)
        self.cjCost = Int(inputs[0])!
        self.jcCost = Int(inputs[1])!
        self.mural = inputs[2].map { $0 }
    }
    
    func output() -> String {
        if let first = self.mural.firstIndex(of: "?") {
            let cost1 = self.calculateCostWithReplacing(at: first, with: "C")
            let cost2 = self.calculateCostWithReplacing(at: first, with: "J")
            return String(min(cost1, cost2))
        } else {
            return String(self.calculateCost())
        }
    }
    
    private func calculateCostWithReplacing(at cursor: Int, with character: Character) -> Int {
        self.mural[cursor] = character
        for index in cursor + 1 ..< self.mural.count {
            if self.mural[index] == "?" {
                let cost1 = self.calculateCostWithReplacing(at: index, with: "C")
                let cost2 = self.calculateCostWithReplacing(at: index, with: "J")
                self.mural[index] = "?"
                return min(cost1, cost2)
            }
        }
        return self.calculateCost()
    }
    
    private func calculateCost() -> Int {
        var cost = 0
        for index in 0 ..< self.mural.count - 1 {
            if self.mural[index] == "C" && self.mural[index+1] == "J" {
                cost += cjCost
            } else if self.mural[index] == "J" && self.mural[index+1] == "C" {
                cost += jcCost
            }
        }
        return cost
    }
}

typealias Solution = CodyJamal

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
    Test(input: "2 3 CJ?CC?", expected: "5"),
    Test(input: "4 2 CJCJ", expected: "10"),
    Test(input: "1 3 C?J", expected: "1"),
    Test(input: "2 5 ??J???", expected: "0"),
    Test(input: "2 -5 ??JJ??", expected: "-8"),
]

tests.forEach {
    let output = Solution(input: $0.input).output()
    if $0.expected == output {
        print("✅ input: \($0.input), output: \(output)")
    } else {
        print("❗️ input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
}
