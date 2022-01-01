import Foundation

struct Timber {
    
    struct Tree {
        let location: Int
        let height: Int
    }
    
    var trees: [Tree] = []
    
    init(input: String) {
        var inputs = input.split(separator: "\n").map { String($0) }
        let treeCount = Int(inputs.removeFirst())!
        for _ in 0 ..< treeCount {
            let rawTree = inputs.removeFirst().split(separator: " ").map { Int($0)! }
            let tree = Tree(location: rawTree[0], height: rawTree[1])
            self.trees.append(tree)
        }
        self.trees.sort { $0.location < $1.location }
    }
    
    func output() -> String {
        var result: (from: Int, to: Int)
        for index in 0 ..< self.trees.count {
            let smallResult = self.calculate(Array(self.trees[0..<index]))
        }
    }
    
    func calculate(_ trees: [Tree]) -> (Int, Int) {
        
    }
}

typealias TestCase = Timber

class Solution {
    
    func start() {
        let name = "small"
        let path = Bundle.main.path(forResource: "\(name)-input", ofType: "txt")!
        var inputs = (try! String(contentsOfFile: path)).components(separatedBy: "\n").filter({ !$0.isEmpty })
        var outputs = Array<String>()
        let testCount = Int(inputs.removeFirst())!
        for index in 0 ..< testCount {
            let inputLines = Int(inputs.removeFirst())!
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
        2
        0 5
        5 4
        """,
         expected:
        """
        9
        """
    ),
    Test(input:
        """
        2
        0 5
        9 4
        """,
         expected:
        """
        9
        """
    ),
    Test(input:
        """
        3
        0 5
        9 3
        2 6
        """,
         expected:
        """
        6
        """
    ),
    Test(input:
        """
        5
        3 2
        2 8
        -4 5
        8 5
        1 4
        """,
         expected:
        """
        12
        """
    ),
    Test(input:
        """
        6
        -15 15
        -9 9
        -3 3
        5 5
        9 9
        18 18
        """,
         expected:
        """
        33
        """
    ),
    Test(input:
        """
        8
        10 20
        20 20
        30 20
        40 20
        50 20
        60 20
        70 20
        80 20
        """,
         expected:
        """
        80
        """
    ),
    Test(input:
        """
        12
        13 8
        -14 5
        2 19
        33 10
        -31 9
        15 21
        5 3
        -22 16
        -6 11
        25 12
        -40 24
        21 18
        """,
         expected:
        """
        56
        """
    ),
    Test(input:
        """
        2
        -500000000 500000000
        500000000 500000000
        """,
         expected:
        """
        1000000000
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

//Solution().start()
