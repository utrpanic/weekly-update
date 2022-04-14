final class D1000000 {
  
  typealias Input = (String, String)
  typealias Output = String
  
  let dice: [Int]
  
  convenience init() {
    self.init(input: (readLine()!, readLine()!))
  }
  
  init(input: Input) {
    self.dice = input.1.split(separator: " ")
      .map(String.init)
      .compactMap(Int.init)
  }
  
  func output() -> String {
    let sorted = self.dice.sorted(by: >)
    var top = sorted[0]
    var length = 1
    for index in 1 ..< sorted.count {
      if top - index == 0 { break }
      if top - index > sorted[index] {
        top = sorted[index] + length
      }
      length += 1
    }
    return String(length)
  }
}

typealias Solution = D1000000

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
      "6 10 12 8"
    )
    ,
    """
    4
    """
  ),
  TestCase(
    (
      "6",
      "5 4 5 4 4 4"
    ),
    """
    5
    """
  ),
  TestCase(
    (
      "10",
      "10 10 7 6 7 4 4 5 7 4"
    ),
    """
    9
    """
  ),
  TestCase(
    (
      "1",
      "10"
    )
    ,
    """
    1
    """
  )
]

testCases.forEach {
  let actual = Solution(input: $0.input).output()
  if actual == $0.expected {
    print("▶️ input:")
    print($0.input.0)
    print($0.input.1)
    print("✅ output:")
    print(actual)
  } else {
    print("▶️ input:")
    print($0.input.0)
    print($0.input.1)
    print("ℹ️ expected:")
    print($0.expected)
    print("❗️ actual:")
    print(actual)
  }
  print()
}
