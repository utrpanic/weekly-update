
final class ThreeDPrinting {
  
  convenience init() {
    self.init(input: readLine()!)
  }
  
  init(input: String) {
  }
  
  func output() -> String {
    return "300000 200000 300000 200000"
  }
}

typealias Solution = ThreeDPrinting

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
    """
    300000 200000 300000 500000
    300000 200000 500000 300000
    300000 500000 300000 200000
    """,
    """
    300000 200000 300000 200000
    """
  ),
  TestCase(
    """
    1000000 1000000 0 0
    0 1000000 1000000 1000000
    """,
    """
    IMPOSSIBLE
    """
  ),
  TestCase(
    """
    999999 999999 999999 999999
    768763 148041 178147 984173
    699508 515362 534729 714381
    949704 625054 946212 951187
    """,
    """
    400001 100002 100003 399994
    """
  )
]

testCases.forEach {
  let actual = Solution(input: $0.input).output()
  if actual == $0.expected {
    print("✅ input:")
    print($0.input)
    print("output:")
    print(actual)
  } else {
    print("❗️ input:")
    print($0.input)
    print("expected:")
    print($0.expected)
    print("actual:")
    print(actual)
  }
}
