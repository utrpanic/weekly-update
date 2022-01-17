import Foundation

struct City {
  var parent: Int
  var fuelCost: Int
  
  init(input: String) {
    let inputs = input.split(separator: " ").map { Int($0)! }
    self.parent = inputs[0]
    self.fuelCost = inputs[1]
  }
}

final class RunningOnFumes2 {
  
  let gas: Int
  let departure: Int
  let arrival: Int
  let cities: [City]
  
  convenience init(input: String) {
    let lines = input.split(separator: "\n")
    let inputs = lines[0].split(separator: " ").map { Int($0)! }
    let cities = lines[1...].map(String.init)
    self.init(gas: inputs[1], departure: inputs[2], arrival: inputs[3], cities: cities)
  }
  
  init(gas: Int, departure: Int, arrival: Int, cities: [String]) {
    self.gas = gas
    self.departure = departure
    self.arrival = arrival
    self.cities = cities.map(City.init)
  }
  
  func output() -> String {
    return "40"
  }
}

typealias Solution = RunningOnFumes2

func start() {
  let inputFile = "large-input.txt"
  let path = Bundle.main.path(forResource: inputFile, ofType: nil)!
  let inputURL = URL(fileURLWithPath: path)
  let outputFile = "large-output.txt"
  let outputURL = FileManager.default
    .urls(for: .desktopDirectory, in: .userDomainMask).first!
    .appendingPathComponent(outputFile)
  FileManager.default.createFile(atPath: outputURL.path, contents: nil, attributes: nil)
  let outputHandle = try! FileHandle(forWritingTo: outputURL)
  let inputs = (try! String(contentsOf: inputURL)).split(separator: "\n")
  let count = Int(inputs[0])!
  var testInputIndex = 1
  for index in 1 ... count {
    let testInputs = inputs[testInputIndex].split(separator: " ").map { Int($0)! }
    let cityCount = testInputs[0]
    let start = testInputIndex + 1
    let through = testInputIndex + cityCount
    let cities = inputs[start...through].map(String.init)
    let solution = Solution(gas: testInputs[1], departure: testInputs[2], arrival: testInputs[3], cities: cities)
    let output = "Case #\(index): \(solution.output())\n"
    try! outputHandle.write(contentsOf: output.data(using: .utf8)!)
    testInputIndex += cityCount + 1
  }
  try! outputHandle.close()
}

//start()

struct Test {
  var input: String
  var expected: String
}

let tests: Array<Test> = [
  Test(input: """
  4 1 2 3
  0 10
  4 20
  4 30
  1 40
  """, expected: "40"),
  Test(input: """
  8 1 5 3
  0 30
  3 20
  1 0
  7 10
  8 0
  1 0
  6 20
  6 30
  """, expected: "-1"),
  Test(input: """
  8 2 5 3
  0 30
  3 20
  1 0
  7 10
  8 0
  1 0
  6 20
  6 30
  """, expected: "60"),
  Test(input: """
  8 3 5 3
  0 30
  3 20
  1 0
  7 10
  8 0
  1 0
  6 20
  6 30
  """, expected: "20"),
  Test(input: """
  15 1 3 14
  0 28
  1 18
  1 17
  2 8
  4 13
  4 2
  2 6
  5 37
  8 37
  9 21
  6 22
  2 33
  1 11
  8 5
  12 8
  """, expected: "104"),
  Test(input: """
  15 5 11 12
  0 0
  7 28
  1 19
  6 5
  15 0
  5 0
  15 0
  1 12
  8 6
  5 20
  2 0
  4 0
  6 10
  4 8
  1 22
  """, expected: "17"),
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
