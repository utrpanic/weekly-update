import Foundation

struct Alchemy {
    
    enum Shard: String {
        case auburn = "A"
        case black = "B"
    }
    
    let shardCount: Int
    let shards: [Shard]
    
    init(input: String) {
        let inputs = input.split(separator: "\n").map { String($0) }
        self.shardCount = Int(inputs[0])!
        self.shards = inputs[1].map { Shard(rawValue: String($0))! }
    }
    
    func output() -> String {
        let aCount = self.shards.filter({ $0 == .auburn }).count
        let bCount = self.shards.filter({ $0 == .black }).count
        return abs(aCount - bCount) == 1 ? "Y" : "N"
    }
}

typealias TestCase = Alchemy

class Solution {
    
    func start() {
        let name = "large"
        let path = Bundle.main.path(forResource: "\(name)-input", ofType: "txt")!
        var inputs = (try! String(contentsOfFile: path)).components(separatedBy: "\n").filter({ !$0.isEmpty })
        var outputs = Array<String>()
        let testCount = Int(inputs.removeFirst())!
        for index in 0 ..< testCount {
            let inputLines = 2
            var caseInput = [String]()
            for _ in 0 ..< inputLines {
                caseInput.append(inputs.removeFirst())
            }
            let result = TestCase(input: caseInput.joined(separator: "\n")).output()
            outputs.append("Case #\(index + 1): \(result)")
        }
        var outputUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
        outputUrl.appendPathComponent("\(name)-output")
        outputUrl.appendPathExtension("txt")
        try! outputs.joined(separator: "\n").write(to: outputUrl, atomically: true, encoding: .utf8)
    }
}

struct Test {
    var input: String
    var expected: String
}

let tests: Array<Test> = [
    Test(input:
        """
        3
        BAB
        """,
         expected:
        """
        Y
        """
    ),
    Test(input:
        """
        3
        BBB
        """,
         expected:
        """
        N
        """
    ),
    Test(input:
        """
        5
        AABBA
        """,
         expected:
        """
        Y
        """
    ),
    Test(input:
        """
        7
        BAAABAA
        """,
         expected:
        """
        N
        """
    ),
    Test(input:
        """
        11
        BBBAABAAAAB
        """,
         expected:
        """
        Y
        """
    ),
    Test(input:
        """
        11
        BABBBABBABB
        """,
         expected:
        """
        N
        """
    )
]

tests.forEach({
    let output = TestCase(input: $0.input).output()
    if $0.expected == output {
        print("[✅] input:\n\($0.input), \noutput: \n\(output)")
    } else {
        print("[❌] input:\n\($0.input), \nexpected: \n\($0.expected), \nactually: \n\(output)")
    }
})

Solution().start()
