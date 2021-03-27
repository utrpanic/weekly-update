
final class ReversortEngineering {
    
    let givenCost: Int
    var totalCost: Int
    var numbers: [Int]
    
    convenience init() {
        self.init(input: readLine()!)
    }
    
    init(input: String) {
        let inputs = input.split(separator: " ")
            .map { String($0) }
            .map { Int($0)! }
        self.numbers = Array(1...inputs[0])
        self.givenCost = inputs[1]
        self.totalCost = inputs[1]
        
    }
    
    func output() -> String {
        let minimumCost = self.numbers.count - 1
        let maximumCost = (0 ..< self.numbers.count).reduce(0) { $0 + $1 } + minimumCost
        guard self.givenCost >= minimumCost else { return "IMPOSSIBLE" }
        guard self.givenCost <= maximumCost else { return "IMPOSSIBLE" }
        self.totalCost -= minimumCost
        for index in (0 ..< self.numbers.count - 1).reversed() {
            self.reverse(at: index)
            if self.totalCost == 0 {
                return self.numbers
                    .map { String($0) }
                    .joined(separator: " ")
            }
        }
        return "IMPOSSIBLE"
    }
    
    private func reverse(at cursor: Int) {
        let maxCost = self.numbers.count - cursor - 1
        let reverseDistance = min(self.totalCost, maxCost)
        for index in 0 ... (reverseDistance / 2) {
            let from = cursor + index
            let to = cursor + (reverseDistance - index)
            let temp = self.numbers[from]
            self.numbers[from] = self.numbers[to]
            self.numbers[to] = temp
        }
        self.totalCost -= reverseDistance
    }
}

let testCaseCount = Int(readLine()!)!
for index in 1 ... testCaseCount {
    let output = ReversortEngineering().output()
    print("Case #\(index): \(output)")
}

let testCases: [(String, String)] = [
    ("4 6", "4 2 1 3"),
    ("2 2", "2 1"),
    ("2 1", "1 2"),
    ("7 12", "7 6 5 4 3 2 1"),
    ("7 2", "IMPOSSIBLE"),
    ("2 1000", "IMPOSSIBLE"),
    ("100 98", "IMPOSSIBLE"),
    ("5 10", "5 4 3 2 1"),
]

testCases.forEach { (input, expected) in
    let reversortEngineering = ReversortEngineering(input: input)
    let result = reversortEngineering.output()
    if result == "IMPOSSIBLE" {
        print(result == expected ? "OK" : result)
    } else {
        let givenCost = String(reversortEngineering.givenCost)
        let resultCost = Reversort(input: result).output()
        print(givenCost == resultCost ? "OK" : result)
    }
}
