import Foundation

final class Timber {
  
  private struct Tree {
    let location: Int
    let height: Int
  }
  
  private struct Combined {
    var start: Int
    var end: Int
    var length: Int { self.end - self.start }
  }
  
  private var trees: [Tree] = []
  private var rightMax: [Int: Combined] = [:]
  private var leftMax: [Int: Combined] = [:]
  
  convenience init(input: String) {
    let inputs = input.split(separator: "\n").map { String($0) }
    self.init(inputs: Array(inputs[1...]))
  }
  
  init(inputs: [String]) {
    for input in inputs {
      let rawTree = input.split(separator: " ").map { Int($0)! }
      let tree = Tree(location: rawTree[0], height: rawTree[1])
      self.trees.append(tree)
    }
    self.trees.sort { $0.location < $1.location }
  }
  
  func output() -> String {
    self.cutDownTreesToRight()
    self.cutDownTreesToLeft()
    return String(self.findMax())
  }
  
  private func cutDownTreesToRight() {
    self.trees.forEach { tree in
      let position = tree.location + tree.height
      let candidate: Combined
      if let previous = self.rightMax[tree.location] {
        candidate = Combined(start: previous.start, end: position)
      } else {
        candidate = Combined(start: tree.location, end: position)
      }
      if let max = self.rightMax[position], candidate.length < max.length {
        // do nothing.
      } else {
        self.rightMax[position] = candidate
      }
    }
  }
  
  private func cutDownTreesToLeft() {
    self.trees.reversed().forEach { tree in
      let position = tree.location - tree.height
      let candidate: Combined
      if let previous = self.leftMax[tree.location] {
        candidate = Combined(start: position, end: previous.end)
      } else {
        candidate = Combined(start: position, end: tree.location)
      }
      if let max = self.leftMax[position], candidate.length < max.length {
        // do nothing.
      } else {
        self.leftMax[position] = candidate
      }
    }
  }
  
  private func findMax() -> Int {
    let rightKeys = Array(self.rightMax.keys)
    let leftKeys = Array(self.leftMax.keys)
    var maxLength = 0
    Set(rightKeys + leftKeys).forEach { position in
      let right = self.rightMax[position]?.length ?? 0
      let left = self.leftMax[position]?.length ?? 0
      maxLength = max(maxLength, right + left)
    }
    return maxLength
  }
}

typealias TestCase = Timber

class Solution {
  
  func start() {
    let name = "large"
    let path = Bundle.main.path(forResource: "\(name)-input", ofType: "txt")!
    let inputs = (try! String(contentsOfFile: path))
      .components(separatedBy: "\n")
      .filter({ !$0.isEmpty })
    var outputURL = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    outputURL.appendPathComponent("\(name)-output")
    outputURL.appendPathExtension("txt")
    let outputHandle = try! FileHandle(forWritingTo: outputURL)
    let testCount = Int(inputs[0])!
    var testInputCountIndex = 1
    for index in 0 ..< testCount {
      let inputCountString = inputs[testInputCountIndex]
      let inputCount = Int(inputCountString)!
      let inputStartIndex = testInputCountIndex + 1
      let inputEndIndex = testInputCountIndex + inputCount
      let caseInput = inputs[inputStartIndex...inputEndIndex]
      let result = TestCase(inputs: Array(caseInput)).output()
      let output = "Case #\(index + 1): \(result)\n"
      try! outputHandle.write(contentsOf: output.data(using: .utf8)!)
      testInputCountIndex += inputCount + 1
    }
    try! outputHandle.close()
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

Solution().start()
