
final class ReversortEngineering {
    
    let length: Int
    let cost: Int
    
    convenience init() {
        self.init(input: readLine()!)
    }
    
    init(input: String) {
        let inputs = input.split(separator: " ")
            .map { String($0) }
            .map { Int($0)! }
        self.length = inputs[0]
        self.cost = inputs[1]
    }
    
    func output() -> String {
        return "4 2 1 3"
    }
}

//let testCaseCount = Int(readLine()!)!
//for index in 1 ... testCaseCount {
//    let output = ReversortEngineering().output()
//    print("Case #\(index): \(output)")
//}

let testCases: [(String, String)] = [
    ("4 6", "4 2 1 3"),
    ("2 1", "1 2"),
    ("7 12", "7 6 5 4 3 2 1"),
    ("7 2", "IMPOSSIBLE"),
    ("2 1000", "IMPOSSIBLE"),
]

testCases.forEach { (input, expected) in
    let reversortEngineering = ReversortEngineering(input: input)
    let result = reversortEngineering.output()
    if result == "IMPOSSIBLE" {
        print(result == expected ? "OK" : result)
    } else {
        let givenCost = String(reversortEngineering.cost)
        let resultCost = Reversort(input: result).output()
        print(givenCost == resultCost ? "OK" : result)
    }
}
