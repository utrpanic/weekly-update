final class ThreeDPrinting {
  
  typealias Input = (String, String, String)
  typealias Output = String
  
  let cyan: [Int]
  let magenta: [Int]
  let yellow: [Int]
  let black: [Int]
  
  convenience init() {
    self.init(input: (readLine()!, readLine()!, readLine()!))
  }
  
  init(input: Input) {
    let print0 = input.0.split(separator: " ").map(String.init).compactMap(Int.init)
    let print1 = input.1.split(separator: " ").map(String.init).compactMap(Int.init)
    let print2 = input.2.split(separator: " ").map(String.init).compactMap(Int.init)
    self.cyan = [print0[0], print1[0], print2[0]]
    self.magenta = [print0[1], print1[1], print2[1]]
    self.yellow = [print0[2], print1[2], print2[2]]
    self.black = [print0[3], print1[3], print2[3]]
  }
  
  func output() -> String {
    let inkUnits = 1000000
    var sum = 0
    var output = ""
    
    let maxCyan = self.cyan.min()!
    sum += maxCyan
    output.append("\(maxCyan)")
    
    var maxMagenta = self.magenta.min()!
    if sum + maxMagenta > inkUnits {
      maxMagenta = inkUnits - sum
    }
    sum += maxMagenta
    output.append(" \(maxMagenta)")
    
    var maxYellow = self.yellow.min()!
    if sum + maxYellow > inkUnits {
      maxYellow = inkUnits - sum
    }
    sum += maxYellow
    output.append(" \(maxYellow)")
    
    var maxBlack = self.black.min()!
    if sum + maxBlack > inkUnits {
      maxBlack = inkUnits - sum
    }
    sum += maxBlack
    output.append(" \(maxBlack)")
    
    if sum == inkUnits {
      return output
    } else {
      return "IMPOSSIBLE"
    }
  }
}

typealias Solution = ThreeDPrinting

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
    "300000 200000 300000 500000",
    "300000 200000 500000 300000",
    "300000 500000 300000 200000"
    ),
    """
    300000 200000 300000 200000
    """
  ),
  TestCase(
    (
    "1000000 1000000 0 0",
    "0 1000000 1000000 1000000",
    "999999 999999 999999 999999"
    ),
    """
    IMPOSSIBLE
    """
  ),
  TestCase(
    (
    "768763 148041 178147 984173",
    "699508 515362 534729 714381",
    "949704 625054 946212 951187"
    ),
    """
    699508 148041 152451 0
    """
  )
]

testCases.forEach {
  let actual = Solution(input: $0.input).output()
  if actual == $0.expected {
    print("▶️ input:")
    print($0.input.0)
    print($0.input.1)
    print($0.input.2)
    print("✅ output:")
    print(actual)
  } else {
    print("▶️ input:")
    print($0.input.0)
    print($0.input.1)
    print($0.input.2)
    print("ℹ️ expected:")
    print($0.expected)
    print("❗️ actual:")
    print(actual)
  }
  print()
}
