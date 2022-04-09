final class DoubleOrOneThing {
  
  typealias Input = String
  typealias Output = String
  
  convenience init() {
    self.init(input: (readLine()!))
  }
  
  init(input: Input) {
    
  }
  
  func output() -> String {
    return "PEEEEL"
  }
}

typealias Solution = DoubleOrOneThing

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
    "PEEL"
    ,
    "PEEEEL"
  ),
  TestCase(
    "AAAAAAAAAA"
    ,
    "AAAAAAAAAA"
  ),
  TestCase(
    "CODEJAMDAY"
    ,
    "CCODDEEJAAMDAAY"
  )
]

testCases.forEach {
  let actual = Solution(input: $0.input).output()
  if actual == $0.expected {
    print("▶️ input:")
    print($0.input)
    print("✅ output:")
    print(actual)
  } else {
    print("▶️ input:")
    print($0.input)
    print("ℹ️ expected:")
    print($0.expected)
    print("❗️ actual:")
    print(actual)
  }
  print()
}
