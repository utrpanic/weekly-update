final class ChainReactions {
  
  typealias Input = (String, String, String)
  typealias Output = String
  
  convenience init() {
    self.init(input: (readLine()!, readLine()!, readLine()!))
  }
  
  init(input: Input) {
    
  }
  
  func output() -> String {
    return "110"
  }
}

typealias Solution = ChainReactions

func start() {
  let testCaseCount = readLine().flatMap(Int.init)!
  for index in 1 ... testCaseCount {
    print("Case #\(index): \(Solution().output())")
  }
}

//start()

struct TestCase {
  let input: Solution.Input
  let expected: Solution.Output
  init(_ input: Solution.Input, _ expected: Solution.Output) {
    self.input = input
    self.expected = expected
  }
}

let testCases = [
  TestCase(
    (
      "4",
      "60 20 40 50",
      "0 1 1 2"
    )
    ,
    """
    110
    """
  ),
  TestCase(
    (
      "5",
      "3 2 1 4 5",
      "0 1 1 1 0"
    ),
    """
    14
    """
  ),
  TestCase(
    (
      "8",
      "100 100 100 90 80 100 90 100",
      "0 1 2 1 2 3 1 3"
    ),
    """
    490
    """
  )
]

testCases.forEach {
  let actual = Solution(input: $0.input).output()
  print("▶️ input:")
  print($0.input.0)
  print($0.input.1)
  print($0.input.2)
  if actual == $0.expected {
    print("✅ output:")
    print(actual)
  } else {
    print("ℹ️ expected:")
    print($0.expected)
    print("❗️ actual:")
    print(actual)
  }
  print()
}
