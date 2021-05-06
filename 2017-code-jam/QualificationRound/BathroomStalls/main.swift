
class BathroomStalls {
    
    let emptyStallCount: Int
    let peopleCount: Int
    
    init(input: String) {
        let inputs = input.split(separator: " ")
        self.emptyStallCount = Int(inputs[0])!
        self.peopleCount = Int(inputs[1])!
    }
    
    func output() -> String {
        var emptyStallCount = self.emptyStallCount
        var peopleCount = self.peopleCount
        while true {
            emptyStallCount -= 1
            peopleCount -= 1
            let leftEmptyStallCount = emptyStallCount / 2
            let rightEmptyStallCount = emptyStallCount - leftEmptyStallCount
            if peopleCount == 0 {
                return "\(rightEmptyStallCount) \(leftEmptyStallCount)"
            } else {
                if leftEmptyStallCount == rightEmptyStallCount {
                    let leftPeopleCount = (peopleCount + 1) / 2
                    let rightPeopleCount = peopleCount - leftPeopleCount
                    if leftPeopleCount > rightPeopleCount {
                        emptyStallCount = leftEmptyStallCount
                        peopleCount = leftPeopleCount
                    } else {
                        emptyStallCount = rightEmptyStallCount
                        peopleCount = rightPeopleCount
                    }
                } else {
                    let leftPeopleCount = (peopleCount) / 2
                    let rightPeopleCount = peopleCount - leftPeopleCount
                    if leftPeopleCount < rightPeopleCount {
                        emptyStallCount = rightEmptyStallCount
                        peopleCount = rightPeopleCount
                    } else {
                        emptyStallCount = leftEmptyStallCount
                        peopleCount = leftPeopleCount
                    }
                }
            }
        }
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
    Test(input: "1000000000000000000 1000000000000000000", expected: "0 0"),
]

tests.forEach({
    let output = BathroomStalls(input: $0.input).output()
    if $0.expected == output {
        print("✅ input: \($0.input), output: \(output)")
    } else {
        print("❗️ input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
})
