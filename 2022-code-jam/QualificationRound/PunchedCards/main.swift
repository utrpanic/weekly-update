
final class PunchedCards {
  
  let codeRow: Int
  let codeCol: Int
  
  convenience init() {
    self.init(input: readLine()!)
  }
  
  init(input: String) {
    let inputs = input.split(separator: " ").map(String.init).compactMap(Int.init)
    self.codeRow = inputs[0]
    self.codeCol = inputs[1]
  }
  
  func output() -> String {
    var output = ""
    let numberOfRow = self.codeRow * 2 + 1
    let numberOfCol = self.codeCol * 2 + 1
    for row in 0 ..< numberOfRow {
      output.append(self.generateLine(row: row, numberOfCol: numberOfCol))
      output.append("\n")
    }
    output.removeLast(1)
    return output
  }
  
  private func generateLine(row: Int, numberOfCol: Int) -> String {
    var line = ""
    for col in 0 ..< numberOfCol {
      if row == 0 && (col == 0 || col == 1) {
        line.append(".")
      } else if row == 1 && col == 0 {
        line.append(".")
      } else {
        if row % 2 == 0 {
          if col % 2 == 0 {
            line.append("+")
          } else {
            line.append("-")
          }
        } else {
          if col % 2 == 0 {
            line.append("|")
          } else {
            line.append(".")
          }
        }
      }
    }
    return line
  }
}

typealias Solution = PunchedCards

func start() {
  let testCaseCount = readLine().flatMap(Int.init)!
  for index in 1 ... testCaseCount {
    print("Case #\(index):")
    print(Solution().output())
  }
}

//start()

struct TestCase {
  let input: String
  let expected: String
  init(_ input: String, _ expected: String) {
    self.input = input
    self.expected = expected
  }
}

let testCases = [
  TestCase(
    "3 4",
    """
    ..+-+-+-+
    ..|.|.|.|
    +-+-+-+-+
    |.|.|.|.|
    +-+-+-+-+
    |.|.|.|.|
    +-+-+-+-+
    """
  ),
  TestCase(
    "2 2",
    """
    ..+-+
    ..|.|
    +-+-+
    |.|.|
    +-+-+
    """
  ),
  TestCase(
    "2 3",
    """
    ..+-+-+
    ..|.|.|
    +-+-+-+
    |.|.|.|
    +-+-+-+
    """
  )
]

testCases.forEach {
  let actual = Solution(input: $0.input).output()
  if actual == $0.expected {
    print("✅ input: \($0.input)")
    print("output:")
    print(actual)
  } else {
    print("❗️ input: \($0.input)")
    print("expected:")
    print($0.expected)
    print("actual:")
    print(actual)
  }
}
