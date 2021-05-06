
enum Digit: Character {
    case _0 = "0"
    case _1 = "1"
    case _2 = "2"
    case _3 = "3"
    case _4 = "4"
    case _5 = "5"
    case _6 = "6"
    case _7 = "7"
    case _8 = "8"
    case _9 = "9"
    
    mutating func decrease() {
        let newRawValue = Character(String(Int(String(self.rawValue))! - 1))
        self = Digit(rawValue: newRawValue)!
    }
}

func < (_ lhs: Digit, _ rhs: Digit) -> Bool {
    return Int(String(lhs.rawValue))! < Int(String(rhs.rawValue))!
}

class TidyNumbers {
    
    var number: [Digit]
    
    init(input: String) {
        self.number = input.compactMap({ Digit(rawValue: $0) })
    }
    
    func output() -> String {
        for index in (1 ..< self.number.count).reversed() {
            if self.number[index] < self.number[index - 1] {
                self.fill9(from: index)
                self.number[index - 1].decrease()
            }
        }
        if self.number[0] == ._0 {
            self.number.removeFirst()
        }
        return self.number.map({ String($0.rawValue) }).joined()
    }
    
    func fill9(from: Int) {
        for index in from ..< self.number.count {
            self.number[index] = ._9
        }
    }
}

func start() {
    let count = Int(readLine()!)!
    for index in 1 ... count {
        let input = readLine()!
        let solution = TidyNumbers(input: input)
        print("Case #\(index): \(solution.output())")
    }
}

//start()

struct Test {
    var input: String
    var expected: String
}

let tests: Array<Test> = [
    Test(input: "132", expected: "129"),
    Test(input: "1000", expected: "999"),
    Test(input: "7", expected: "7"),
    Test(input: "111111111111111110", expected: "99999999999999999"),
]

tests.forEach({
    let output = TidyNumbers(input: $0.input).output()
    if $0.expected == output {
        print("[SUCCESS] input: \($0.input), output: \(output)")
    } else {
        print("[FAILURE] input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
})
