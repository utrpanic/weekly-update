
enum Pancake: Character {
    case happy = "+"
    case blank = "-"
    
    mutating func flip() {
        switch self {
        case .happy: self = .blank
        case .blank: self = .happy
        }
    }
}

class OversizedPancakeFlipper {
    
    var pancakes: [Pancake]
    let flipperSize: Int
    
    var isHappy: Bool { return !self.pancakes.contains(.blank) }
    
    init(input: String) {
        let inputs = input.split(separator: " ")
        self.pancakes = String(inputs[0]).compactMap({ Pancake(rawValue: $0) })
        self.flipperSize = Int(String(inputs[1]))!
    }
    
    func output() -> String {
        var flipCount = 0
        for index in 0 ..< self.pancakes.count {
            switch self.pancakes[index] {
            case .happy:
                continue
            case .blank:
                self.flip(at: index)
                flipCount += 1
            }
        }
        return self.isHappy ? String(flipCount) : "IMPOSSIBLE"
        
    }

    private func flip(at startIndex: Int) {
        guard startIndex + self.flipperSize <= self.pancakes.count else { return }
        for index in startIndex ..< self.pancakes.count {
            if index < startIndex + self.flipperSize {
                self.pancakes[index].flip()
            } else {
                break
            }
        }
    }
}

func start() {
    let count = Int(readLine()!)!
    for index in 1 ... count {
        let input = readLine()!
        let solution = OversizedPancakeFlipper(input: input)
        print("Case #\(index): \(solution.output())")
    }
}

//start()

struct Test {
    var input: String
    var expected: String
}

let tests: Array<Test> = [
    Test(input: "---+-++- 3", expected: "3"),
    Test(input: "+++++ 4", expected: "0"),
    Test(input: "-+-+- 4", expected: "IMPOSSIBLE"),
]

tests.forEach({
    let output = OversizedPancakeFlipper(input: $0.input).output()
    if $0.expected == output {
        print("[SUCCESS] input: \($0.input), output: \(output)")
    } else {
        print("[FAILURE] input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
})
