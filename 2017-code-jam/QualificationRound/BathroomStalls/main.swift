
class BathroomStalls {
    var emptyStalls: [(Int, Int)]
    let numberOfPeople: Int
    
    init(input: String) {
        let inputs = input.split(separator: " ")
        self.emptyStalls = [(Int(inputs[0])!, 1)]
        self.numberOfPeople = Int(inputs[1])!
    }
    
    func output() -> String {
        var waitingPeople = self.numberOfPeople
        while waitingPeople > self.emptyStalls[0].1 {
            let stalls = self.emptyStalls.removeFirst()
            let (large, small) = self.retrieveLargeSmallStalls(stalls.0)
            self.insertEmptyStalls(large, count: stalls.1)
            self.insertEmptyStalls(small, count: stalls.1)
            waitingPeople -= stalls.1
        }
        let stalls = self.emptyStalls.removeFirst().0
        let (large, small) = self.retrieveLargeSmallStalls(stalls)
        return "\(large) \(small)"
    }
    
    func insertEmptyStalls(_ emptyStalls: Int, count: Int) {
        guard emptyStalls > 0 else { return }
        if self.emptyStalls.contains(where: { $0.0 == emptyStalls }) {
            for index in 0 ..< self.emptyStalls.count {
                if self.emptyStalls[index].0 == emptyStalls {
                    self.emptyStalls[index].1 += count
                    break
                }
            }
        } else {
            self.emptyStalls.append((emptyStalls, count))
        }
    }
    
    func retrieveLargeSmallStalls(_ emptyStalls: Int) -> (large: Int, small: Int) {
        let largeStalls: Int = emptyStalls / 2
        let smallStalls: Int = emptyStalls % 2 == 0 ? max(0, largeStalls - 1) : largeStalls
        return (large: largeStalls, small: smallStalls)
    }
}

func start() {
    let count = Int(readLine()!)!
    for index in 1 ... count {
        let input = readLine()!
        let solution = BathroomStalls(input: input)
        print("Case #\(index): \(solution.output())")
    }
}

//start()

struct Test {
    var input: String
    var expected: String
}

let tests: Array<Test> = [
    Test(input: "4 2", expected: "1 0"),
    Test(input: "5 2", expected: "1 0"),
    Test(input: "6 2", expected: "1 1"),
    Test(input: "1000 1000", expected: "0 0"),
    Test(input: "1000 1", expected: "500 499"),
    Test(input: "999 499", expected: "1 0"),
    Test(input: "1000 489", expected: "1 0"),
]

tests.forEach({
    let output = BathroomStalls(input: $0.input).output()
    if $0.expected == output {
        print("[SUCCESS] input: \($0.input), output: \(output)")
    } else {
        print("[FAILURE] input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
})
