
final class PunchedCards {
  
  convenience init() {
    self.init(input: readLine()!)
  }
  
  init(input: String) {
    
  }
  
  func output() -> String {
    return """
    ..+-+-+-+
    ..|.|.|.|
    +-+-+-+-+
    |.|.|.|.|
    +-+-+-+-+
    |.|.|.|.|
    +-+-+-+-+
    """
  }
}

typealias Solution = PunchedCards

func start() {
  let testCaseCount = readLine().flatMap(String.init).flatMap(Int.init)!
  for index in 1 ... testCaseCount {
    print("Case #\(index):")
    print(Solution().output())
  }
}

// start()

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
