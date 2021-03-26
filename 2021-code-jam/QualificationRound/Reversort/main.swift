



final class Reversort {
    
    var numbers: [Int]
    
    convenience init() {
        _ = readLine()
        self.init(input: readLine()!)
    }
    
    init(input: String) {
        self.numbers = input.split(separator: " ")
            .map { String($0) }
            .map { Int($0)! }
    }
    
    func output() -> String {
        return "6"
    }
}

let testCases: [(String, String)] = [
    ("4 2 1 3", "6"),
    ("1 2", "1"),
    ("7 6 5 4 3 2 1", "12")
    
]

testCases.forEach { (input, expected) in
    let result = Reversort(input: input).output()
    print(result == expected ? "OK" : result)
}
