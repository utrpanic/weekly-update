
class CountingSheep {
    
    static var insomnia: String { return "INSOMNIA" }
    
    private var startNumber: Int
    private var checkBoxes: Array<Bool>
    
    init(input: String) {
        self.startNumber = Int(input)!
        self.checkBoxes = Array<Bool>(repeating: false, count: 10)
    }
    
    convenience init() {
        let input = readLine()!
        self.init(input: input)
    }
    
    func output() -> String {
        guard self.startNumber > 0 else { return CountingSheep.insomnia }
        var currentNumber = self.startNumber
        repeat {
            self.checkNewNumber(currentNumber)
            if self.checkInSleep() {
                return String(currentNumber)
            } else {
                currentNumber += self.startNumber
            }
        } while String(currentNumber).count < String(self.startNumber).count + 2
        
        return CountingSheep.insomnia
    }
    
    private func checkNewNumber(_ number: Int) {
        String(number).forEach {
            let digit = Int(String($0))!
            self.checkBoxes[digit] = true
        }
    }
    
    private func checkInSleep() -> Bool {
        return !self.checkBoxes.contains(false)
    }
}

typealias Solution = CountingSheep

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
    Test(input: "0", expected: "INSOMNIA"),
    Test(input: "1", expected: "10"),
    Test(input: "2", expected: "90"),
    Test(input: "11", expected: "110"),
    Test(input: "1692", expected: "5076"),
]

tests.forEach {
    let output = Solution(input: $0.input).output()
    if $0.expected == output {
        print("✅ input: \($0.input), output: \(output)")
    } else {
        print("❗️ input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
}
