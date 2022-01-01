import Foundation

struct TravelRestrictions {
    
    let countryCount: Int
    let incoming: [Bool]
    let outgoing: [Bool]
    
    init(input: String) {
        let inputs = input.split(separator: "\n").map { String($0) }
        self.countryCount = Int(inputs[0])!
        self.incoming = inputs[1].map { $0 == "Y" }
        self.outgoing = inputs[2].map { $0 == "Y" }
    }
    
    func output() -> String {
        var results = [String]()
        for from in 0 ..< self.countryCount {
            var result = ""
            for to in 0 ..< self.countryCount {
                if from == to {
                    result.append("Y")
                } else if from < to {
                    var available = "Y"
                    for index in stride(from: from, to: to, by: 1) {
                        if self.outgoing[index] && self.incoming[index+1] {
                            // do nothing.
                        } else {
                            available = "N"
                            break
                        }
                    }
                    result.append(available)
                } else if from > to {
                    var available = "Y"
                    for index in stride(from: from, to: to, by: -1) {
                        if self.outgoing[index] && self.incoming[index-1] {
                            // do nothing.
                        } else {
                            available = "N"
                            break
                        }
                    }
                    result.append(available)
                }
            }
            results.append(result)
        }
        return results.joined(separator: "\n")
    }
}

typealias TestCase = TravelRestrictions

class Solution {
    
    func start() {
        let name = "large"
        let path = Bundle.main.path(forResource: "\(name)-input", ofType: "txt")!
        var inputs = (try! String(contentsOfFile: path)).components(separatedBy: "\n").filter({ !$0.isEmpty })
        var outputs = Array<String>()
        let testCount = Int(inputs.removeFirst())!
        for index in 0 ..< testCount {
            let inputLines = 3
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
        YY
        YY
        """,
         expected:
        """
        YY
        YY
        """
    ),
    Test(input:
        """
        2
        NY
        YY
        """,
         expected:
        """
        YY
        NY
        """
    ),
    Test(input:
        """
        2
        NN
        YY
        """,
         expected:
        """
        YN
        NY
        """
    ),
    Test(input:
        """
        5
        YNNYY
        YYYNY
        """,
         expected:
        """
        YNNNN
        YYNNN
        NNYYN
        NNNYN
        NNNYY
        """
    ),
    Test(input:
        """
        10
        NYYYNNYYYY
        YYNYYNYYNY
        """,
         expected:
        """
        YYYNNNNNNN
        NYYNNNNNNN
        NNYNNNNNNN
        NNYYNNNNNN
        NNYYYNNNNN
        NNNNNYNNNN
        NNNNNNYYYN
        NNNNNNYYYN
        NNNNNNNNYN
        NNNNNNNNYY
        """
    )
]

tests.forEach({
    let output = TestCase(input: $0.input).output()
    if $0.expected == output {
        print("[✅] input: \($0.input), \noutput: \n\(output)")
    } else {
        print("[❌] input: \($0.input), \nexpected: \n\($0.expected), \nactually: \n\(output)")
    }
})

Solution().start()
