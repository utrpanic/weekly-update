import Foundation

struct Bar {
    
    enum BarType {
        case leading, trailing
    }
    
    let index: Int
    let type: BarType
    let x: Int
    let y: Int
}

class Perimetric {
    
    let numberOfRooms: Int
    let k: Int
    let width: Int
    
    let ls: [Int]
    let hs: [Int]
    let lConstant: [Int]
    let hConstant: [Int]
    var bars: [Bar]
    var perimeters: [Int]
    
    init(input: String) {
        let inputs = input.split(separator: "\n").map { String($0) }
        let line1 = inputs[0].split(separator: " ").map { Int($0)! }
        self.numberOfRooms = line1[0]
        self.k = line1[1]
        self.width = line1[2]
        self.ls = inputs[1].split(separator: " ").map { Int($0)! }
        self.lConstant = inputs[2].split(separator: " ").map { Int($0)! }
        self.hs = inputs[3].split(separator: " ").map { Int($0)! }
        self.hConstant = inputs[4].split(separator: " ").map { Int($0)! }
        self.bars = []
        self.perimeters = []
        self.setupBars()
    }
    
    private func setupBars() {
        var leadings: [Bar] = []
        for index in 0 ..< self.numberOfRooms {
            let x: Int
            let height: Int
            if index < self.k {
                x = self.ls[index]
                height = self.hs[index]
            } else {
                x = ((self.lConstant[0] * leadings[index - 2].x) +
                    (self.lConstant[1] * leadings[index - 1].x) +
                    (self.lConstant[2])) % self.lConstant[3] + 1
                height = ((self.hConstant[0] * leadings[index - 2].y) +
                    (self.hConstant[1] * leadings[index - 1].y) +
                    (self.hConstant[2])) % self.hConstant[3] + 1
            }
            leadings.append(Bar(index: index, type: .leading, x: x, y: height))
        }
        leadings.forEach {
            self.bars.append($0)
            self.bars.append(Bar(index: $0.index, type: .trailing, x: $0.x + self.width, y: $0.y))
        }
        self.bars.sort {
            if $0.x == $1.x {
                return $0.type == .leading
            } else {
                return $0.x < $1.x
            }
        }
    }
    
    func output() -> String {
        var queue = [Bar]()
        var unions = [Int]()
        var unionMinX = 0
        var unionPerimeter = 0
        self.bars.forEach { bar in
            switch bar.type {
            case .leading:
                let currentY = queue.max(by: { $0.y < $1.y })?.y ?? 0
                if queue.isEmpty {
                    unionMinX = bar.x
                }
                if bar.y - currentY > 0 {
                    unionPerimeter += bar.y - currentY
                }
                queue.append(bar)
            case .trailing:
                let previousY = queue.filter({ $0.index <= bar.index }).max(by: { $0.y < $1.y })?.y ?? 0
                queue.removeFirst()
                if queue.isEmpty {
                    unionPerimeter += bar.y + ((bar.x - unionMinX) * 2)
                    unions.append(unionPerimeter)
                    self.perimeters.append(unions.reduce(0) { $0 + $1 })
                    unionPerimeter = 0
                } else {
                    self.perimeters.append(unions.reduce(0) { $0 + $1 } + unionPerimeter + previousY + ((bar.x - unionMinX) * 2))
                    let currentY = queue.max(by: { $0.y < $1.y })?.y ?? 0
                    if previousY - currentY > 0 {
                        unionPerimeter += previousY - currentY
                    }
                }
            }
        }
        let result = self.perimeters.reduce(1) { ($0 % 1_000_000_007) * ($1 % 1_000_000_007) }
        return String(result % 1_000_000_007)
    }
}

typealias TestCase = Perimetric

struct Test {
    var input: String
    var expected: String
}

let tests: Array<Test> = [
//    Test(input:
//        """
//        2 2 2
//        1 2
//        0 0 0 100
//        3 3
//        0 0 0 100
//        """,
//         expected:
//        """
//        120
//        """
//    ),
//    Test(input:
//        """
//        2 2 2
//        10 20
//        0 0 0 100
//        3 3
//        0 0 0 100
//        """,
//         expected:
//        """
//        200
//        """
//    ),
    Test(input:
        """
        5 5 3
        2 4 5 9 12
        0 0 0 100
        4 3 6 3 2
        0 0 0 100
        """,
         expected:
        """
        9144576
        """
    ),
//    Test(input:
//        """
//        10 3 8
//        9 14 15
//        0 1 3 53
//        12 7 16
//        5 2 1 38
//        """,
//         expected:
//        """
//        803986060
//        """
//    ),
//    Test(input:
//        """
//        50 10 17
//        4 9 10 26 28 59 97 100 105 106
//        1 0 7 832
//        130 12 82 487 12 30 214 104 104 527
//        21 81 410 605
//        """,
//         expected:
//        """
//        271473330
//        """
//    )
]

tests.forEach({
    let output = TestCase(input: $0.input).output()
    if $0.expected == output {
        print("[✅] input:\n\($0.input), \noutput: \n\(output)")
    } else {
        print("[❌] input:\n\($0.input), \nexpected: \n\($0.expected), \nactually: \n\(output)")
    }
})

class Solution {
    
    func start() {
        let name = "small"
        let path = Bundle.main.path(forResource: "\(name)-input", ofType: "txt")!
        var inputs = (try! String(contentsOfFile: path)).components(separatedBy: "\n").filter({ !$0.isEmpty })
        var outputs = Array<String>()
        let testCount = Int(inputs.removeFirst())!
        for index in 0 ..< testCount {
            let inputLines = 5
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

//Solution().start()
