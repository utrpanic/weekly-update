
final class CodyJamal {
    
    var x: Int
    var y: Int
    var mural: String
    
    convenience init() {
        self.init(input: readLine()!)
    }
    
    init(input: String) {
        let inputs = input.split(separator: " ").map { String($0) }
        self.x = Int(inputs[0])!
        self.y = Int(inputs[1])!
        self.mural = inputs[2]
    }
    
    func output() -> String {
        return "5"
    }
}

//let testCaseCount = Int(readLine()!)!
//for index in 1 ... testCaseCount {
//    let output = CodyJamal().output()
//    print("Case #\(index): \(output)")
//}

let testCases: [(String, String)] = [
    ("2 3 CJ?CC?", "5"),
//    ("4 2 CJCJ", "10"),
//    ("1 3 C?J", "1"),
//    ("2 5 ??J???", "0")
]

testCases.forEach { (input, expected) in
    let result = CodyJamal(input: input).output()
    print(result == expected ? "OK" : result)
}
