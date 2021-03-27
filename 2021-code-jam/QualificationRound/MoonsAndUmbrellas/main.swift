
final class CodyJamal {
    
    var cjCost: Int
    var jcCost: Int
    var mural: [Character]
    
    convenience init() {
        self.init(input: readLine()!)
    }
    
    init(input: String) {
        let inputs = input.split(separator: " ").map { String($0) }
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

let testCaseCount = Int(readLine()!)!
for index in 1 ... testCaseCount {
    let output = CodyJamal().output()
    print("Case #\(index): \(output)")
}

let testCases: [(String, String)] = [
    ("2 3 CJ?CC?", "5"),
    ("4 2 CJCJ", "10"),
    ("1 3 C?J", "1"),
    ("2 5 ??J???", "0"),
    ("2 -5 ??JJ??", "-8")
]

testCases.forEach { (input, expected) in
    let result = CodyJamal(input: input).output()
    print(result == expected ? "OK" : result)
}
