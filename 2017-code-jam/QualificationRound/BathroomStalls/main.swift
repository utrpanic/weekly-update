
class BathroomStalls {
    
    var stalls: [Bool]
    let peopleCount: Int
    
    init(input: String) {
        let inputs = input.split(separator: " ")
        let stallCount = Int(inputs[0])! + 2
        var stalls = Array(repeating: false, count: stallCount)
        stalls[0] = true
        stalls[stalls.count - 1] = true
        self.stalls = stalls
        self.peopleCount = Int(inputs[1])!
    }
    
    func output() -> String {
        let lastIndex = self.lastOccupiedStallIndex(start: 0, emptyStallCount: self.stalls.count - 2, peopleCount: self.peopleCount)
        let result = self.leftRightEmptyStalls(index: lastIndex)
        let max = Swift.max(result.left, result.right)
        let min = Swift.min(result.left, result.right)
        return "\(max) \(min)"
    }
    
    func lastOccupiedStallIndex(start: Int, emptyStallCount: Int, peopleCount: Int) -> Int {
        let pivot = start + (emptyStallCount + 1) / 2
        self.stalls[pivot] = true
        let newEmptyStallCount = emptyStallCount - 1
        let newPeopleCount = peopleCount - 1
        if newPeopleCount == 0 {
            return pivot
        } else {
            let leftStart = start
            let leftEmptyStallCount = pivot - start - 1
            let leftPeopleCount: Int
            let rightStart = pivot
            let rightEmptyStallCount = newEmptyStallCount - leftEmptyStallCount
            let rightPeopleCount: Int
            if leftEmptyStallCount == rightEmptyStallCount {
                leftPeopleCount = (newPeopleCount + 1) / 2
                rightPeopleCount = newPeopleCount - leftPeopleCount
                if rightPeopleCount == 0 {
                    return self.lastOccupiedStallIndex(start: leftStart, emptyStallCount: leftEmptyStallCount, peopleCount: leftPeopleCount)
                } else {
                    let leftIndex = self.lastOccupiedStallIndex(start: leftStart, emptyStallCount: leftEmptyStallCount, peopleCount: leftPeopleCount)
                    let rightIndex = self.lastOccupiedStallIndex(start: rightStart, emptyStallCount: rightEmptyStallCount, peopleCount: rightPeopleCount)
                    return leftPeopleCount == rightPeopleCount ? rightIndex : leftIndex
                }
            } else {
                leftPeopleCount = (newPeopleCount) / 2
                rightPeopleCount = newPeopleCount - leftPeopleCount
                if leftPeopleCount == 0 {
                    return self.lastOccupiedStallIndex(start: rightStart, emptyStallCount: rightEmptyStallCount, peopleCount: rightPeopleCount)
                } else {
                    let leftIndex = self.lastOccupiedStallIndex(start: leftStart, emptyStallCount: leftEmptyStallCount, peopleCount: leftPeopleCount)
                    let rightIndex = self.lastOccupiedStallIndex(start: rightStart, emptyStallCount: rightEmptyStallCount, peopleCount: rightPeopleCount)
                    return leftPeopleCount == rightPeopleCount ? leftIndex : rightIndex
                }
            }
        }
    }
    
    func leftRightEmptyStalls(index: Int) -> (left: Int, right: Int) {
        var left: Int = 0
        for index in (0 ..< index).reversed() {
            if self.stalls[index] {
                break
            } else {
                left += 1
            }
        }
        var right: Int = 0
        for index in (index + 1 ..< self.stalls.count) {
            if self.stalls[index] {
                break
            } else {
                right += 1
            }
        }
        return (left, right)
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
