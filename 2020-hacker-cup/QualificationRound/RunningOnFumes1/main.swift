import Foundation

final class RunningOnFumes1 {
  
  let cities: [Int]
  let gas: Int
  var fCosts: [Int?]
  var gCosts: [Int?]
  
  convenience init(input: String) {
    let inputs = input.split(separator: "\n")
    let gas = Int(inputs[0].split(separator: " ")[1])!
    let cities = inputs[1...].map { Int($0)! }
    self.init(cities: cities, gas: gas)
  }
  
  init(cities: [Int], gas: Int) {
    self.cities = cities
    self.gas = gas
    self.gCosts = Array(repeating: nil, count: cities.count)
    self.fCosts = Array(repeating: nil, count: cities.count)
  }
  
  func output() -> String {
    for index in 0 ..< self.cities.count {
      if index == 0 {
        self.fCosts[0] = 0
        self.gCosts[0] = 0
      } else if index <= self.gas {
        self.gCosts[index] = 0
        if self.cities[index] > 0 {
          self.fCosts[index] = self.gCosts[index].map { $0 + self.cities[index] }
        } else {
          self.fCosts[index] = nil
        }
      } else {
        let start = index - self.gas
        let end = index
        self.gCosts[index] = self.fCosts[start...end].compactMap { $0 }.min()
        if self.cities[index] > 0 {
          self.fCosts[index] = self.gCosts[index].map { $0 + self.cities[index] }
        } else {
          self.fCosts[index] = nil
        }
      }
    }
    if let result = self.gCosts.last! {
      return "\(result)"
    } else {
      return "-1"
    }
  }
}

typealias Solution = RunningOnFumes1

//func start() {
//  let inputFile = "large-input.txt"
//  let path = Bundle.main.path(forResource: inputFile, ofType: nil)!
//  let inputURL = URL(fileURLWithPath: path)
//  let outputFile = "large-output.txt"
//  let outputURL = FileManager.default
//    .urls(for: .desktopDirectory, in: .userDomainMask).first!
//    .appendingPathComponent(outputFile)
//  let outputHandle = try! FileHandle(forWritingTo: outputURL)
//  let inputs = (try! String(contentsOf: inputURL)).split(separator: "\n")
//  let count = Int(inputs[0])!
//  var testInputIndex = 1
//  for index in 1 ... count {
//    let testInputs = inputs[testInputIndex].split(separator: " ")
//    let cityCount = Int(testInputs[0])!
//    let start = testInputIndex + 1
//    let through = testInputIndex + cityCount
//    let cities = inputs[start...through].map { Int($0)! }
//    let gas = Int(testInputs[1])!
//    let solution = Solution(cities: cities, gas: gas)
//    let output = "Case #\(index): \(solution.output())"
//    try! outputHandle.write(contentsOf: output.data(using: .utf8)!)
//    testInputIndex += cityCount + 1
//  }
//  try! outputHandle.close()
//}
//
//start()

struct Test {
  var input: String
  var expected: String
}

let tests: Array<Test> = [
  Test(input: """
  5 3
  0
  20
  30
  0
  10
  """, expected: "20"),
  Test(input: """
  5 2
  0
  20
  30
  0
  10
  """, expected: "30"),
  Test(input: """
  5 1
  0
  20
  30
  0
  10
  """, expected: "-1"),
  Test(input: """
  4 1
  99
  88
  77
  66
  """, expected: "165"),
  Test(input: """
  4 4
  99
  88
  77
  66
  """, expected: "0"),
  Test(input: """
  6 2
  0
  0
  20
  30
  0
  10
  """, expected: "50"),
  Test(input: """
  12 3
  0
  1
  4
  7
  0
  5
  9
  8
  0
  3
  0
  6
  """, expected: "19"),
]

tests.forEach {
  let output = Solution(input: $0.input).output()
  if $0.expected == output {
    print("[ℹ️] input: \($0.input) \n[✅] output: \(output)")
  } else {
    print("[ℹ️] input: \($0.input) \n[ℹ️] expected: \($0.expected) \n[❌] actually: \(output)")
  }
  print()
}
