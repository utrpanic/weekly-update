final class DoubleOrOneThing {
  
  typealias Input = String
  typealias Output = String
  
  var input: String
  
  convenience init() {
    self.init(input: (readLine()!))
  }
  
  init(input: Input) {
    self.input = input
  }
  
  func output() -> String {
    var result: [Character] = []
    let characters = Array(self.input)
    var sameCharactorCount = 0
    for index in 0 ..< characters.count {
      result.append(characters[index])
      if index + 1 == characters.count { break }
      if characters[index] == characters[index + 1] {
        sameCharactorCount += 1
      } else if characters[index] < characters[index + 1] {
        sameCharactorCount += 1
        for _ in 0 ..< sameCharactorCount {
          result.append(characters[index])
        }
        sameCharactorCount = 0
      } else {
        sameCharactorCount = 0
      }
    }
    return String(result)
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
