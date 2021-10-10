
class Fractiles {
    
    let k: Int
    let complexity: Int
    let students: Int
    
    init(input: String) {
        let inputs = input.split(separator: " ")
            .compactMap { Int($0) }
        self.k = inputs[0]
        self.complexity = inputs[1]
        self.students = inputs[2]
    }
    
    convenience init() {
        let input = readLine()!
        self.init(input: input)
    }
    
    func output() -> String {
        if self.complexity * self.students < self.k {
            return "IMPOSSIBLE"
        } else {
            var tiles: [Int] = []
            for i in stride(from: 1, to: self.k + 1, by: self.complexity) {
                var p = 1
                for j in 0 ..< self.complexity {
                    p = (p - 1) * k + min(i + j, k)
                }
                tiles.append(p)
            }
            return tiles.map { String($0) }
                .joined(separator: " ")
        }
    }
}

typealias Solution = Fractiles

func start() {
    let count = Int(readLine()!)!
    for index in 1 ... count {
        let solution = Solution()
        print("Case #\(index): \(solution.output())")
    }
}

//start()

// If there are multiple valid sets of tiles, you may output any of them.
//struct Test {
//    var input: String
//    var expected: String
//}
//
//let tests: Array<Test> = [
//    Test(input: "2 3 2", expected: "2"),
//    Test(input: "1 1 1", expected: "1"),
//    Test(input: "2 1 1", expected: "IMPOSSIBLE"),
//    Test(input: "2 1 2", expected: "1 2"),
//    Test(input: "3 2 3", expected: "2 6"),
//]
//
//tests.forEach {
//    let output = Solution(input: $0.input).output()
//    if $0.expected == output {
//        print("✅ input: \($0.input), output: \(output)")
//    } else {
//        print("❗️ input: \($0.input), expected: \($0.expected), actually: \(output)")
//    }
//}
