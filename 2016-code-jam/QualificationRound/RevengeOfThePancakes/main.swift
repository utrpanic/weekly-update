
enum Pancake: String {
    
    case happy = "+"
    case blank = "-"
    
    func flip() -> Pancake {
        switch self {
        case .happy: return .blank
        case .blank: return .happy
        }
    }
}

class RevengeOfThePancakes {
    
    private var pancakes: Array<Pancake>
    
    init(input: String) {
        self.pancakes = input.map { Pancake(rawValue: String($0))! }
    }
    
    convenience init() {
        let input = readLine()!
        self.init(input: input)
    }
    
    func output() -> String {
        var flipCount = 0
        while !self.pancakes.reduce(true, { $0 && ($1 == .happy) }) {
            for index in (0 ..< self.pancakes.count).reversed() {
                if case .happy = self.pancakes[index] {
                    self.pancakes.remove(at: index)
                } else {
                    break
                }
            }
            if case .happy = self.pancakes.first! {
                for index in (0 ..< self.pancakes.count).reversed() {
                    if case .happy = self.pancakes[index] {
                        self.pancakes = self.flipPancakes(to: index)
                        flipCount += 1
                        break
                    }
                }
            } else if case .blank = self.pancakes.first! {
                for index in (0 ..< self.pancakes.count).reversed() {
                    if case .blank = self.pancakes[index] {
                        self.pancakes = self.flipPancakes(to: index)
                        flipCount += 1
                        break
                    }
                }
            }
        }
        return String(flipCount)
    }
    
    private func flipPancakes(to: Int) -> Array<Pancake> {
        var flippedPancakes = Array<Pancake>()
        for index in (0 ... to).reversed() {
            flippedPancakes.append(self.pancakes[index].flip())
        }
        for index in (to + 1) ..< self.pancakes.count {
            flippedPancakes.append(self.pancakes[index])
        }
        return flippedPancakes
    }
}

typealias Solution = RevengeOfThePancakes

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
    Test(input: "-", expected: "1"),
    Test(input: "-+", expected: "1"),
    Test(input: "+-", expected: "2"),
    Test(input: "+++", expected: "0"),
    Test(input: "--+-", expected: "3"),
]

tests.forEach {
    let output = Solution(input: $0.input).output()
    if $0.expected == output {
        print("✅ input: \($0.input), output: \(output)")
    } else {
        print("❗️ input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
}
