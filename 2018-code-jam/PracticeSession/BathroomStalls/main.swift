
struct BathroomStalls {
    
    init(input: (Int, Int)) {
        
    }
    
    init() {
        let inputs = readLine()!.split(separator: " ").map { Int($0)! }
        let stalls = inputs[0]
        let people = inputs[1]
        self.init(input: (stalls, people))
    }
    
    func output() -> String {
        return "1 0"
    }
}

func start() {
    let count = Int(readLine()!)!
    for index in 1 ... count {
        let solution = BathroomStalls()
        let result = solution.output()
        print("Case #\(index): \(result)")
    }
}

//start()

struct Test {
    var input: (Int, Int)
    var expected: String
}

let tests: Array<Test> = [
    Test(input: (4, 2), expected: "1 0"),
    Test(input: (5, 2), expected: "1 0"),
    Test(input: (6, 2), expected: "1 1"),
    Test(input: (1000, 1000), expected: "0 0"),
    Test(input: (1000, 1), expected: "500 499"),
]

tests.forEach({
    let solution = BathroomStalls(input: $0.input)
    let output = solution.output()
    if output == $0.expected {
        print("✅ input: \($0.input), expected: \($0.expected)")
    } else {
        print("❗️ input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
})
