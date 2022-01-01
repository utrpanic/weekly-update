final class CodyJamal {
  
  let c: Character = "C"
  let j: Character = "J"
  let space: Character = "?"
  
  var cjCost: Int
  var jcCost: Int
  var mural: [Character]
  
  convenience init() {
    self.init(input: readLine()!)
  }
  
  init(input: String) {
    let inputs = input.split(separator: " ").map(String.init)
    self.cjCost = Int(inputs[0])!
    self.jcCost = Int(inputs[1])!
    self.mural = inputs[2].map { $0 }
  }
  
  func output() -> String {
    var spaces: [(start: Int, throuth: Int)] = []
    var start, through: Int?
    for index in self.mural.indices {
      if self.mural[index] == self.space {
        if start == nil {
          start = index
        }
        through = index
      } else {
        if let start = start, let through = through {
          spaces.append((start, through))
        }
        start = nil
        through = nil
      }
    }
    if let start = start, let through = through {
      spaces.append((start, through))
    }
    spaces.forEach { self.paintSpace($0.start, $0.throuth) }
    let cost = self.calculateCost(self.mural)
    return "\(cost)"
  }
  
  private func paintSpace(_ start: Int, _ through: Int) {
    let left = max(start - 1, 0)
    let right = min(through + 1, self.mural.count - 1)
    let piece = Array(self.mural[left...right])
    let options: [(piece: [Character], cost: Int)] = [
      self.fillC(piece),
      self.fillJ(piece),
      self.fillCJ(piece),
      self.fillJC(piece)
    ].compactMap { $0 }
    let minimumPiece = options.min(by: { $0.cost < $1.cost })!.piece
    for index in left...right {
      self.mural[index] = minimumPiece[index - left]
    }
  }
  
  private func fillC(_ piece: [Character]) -> ([Character], Int) {
    let filled = piece.map { $0 == self.space ? self.c : $0 }
    return (filled, self.calculateCost(filled))
  }
  
  private func fillJ(_ piece: [Character]) -> ([Character], Int) {
    let filled = piece.map { $0 == self.space ? self.j : $0 }
    return (filled, self.calculateCost(filled))
  }
  
  private func fillCJ(_ piece: [Character]) -> ([Character], Int)? {
    guard piece.filter({ $0 == self.space }).count >= 2 else { return nil }
    var filled: [Character] = piece
    var fill: Character = self.c
    for index in filled.indices {
      if filled[index] == self.space {
        filled[index] = fill
        fill = (fill == self.c) ? self.j : self.c
      }
    }
    return (filled, self.calculateCost(filled))
  }
  
  private func fillJC(_ piece: [Character]) -> ([Character], Int)? {
    guard piece.filter({ $0 == self.space }).count >= 2 else { return nil }
    var filled: [Character] = piece
    var fill: Character = self.j
    for index in filled.indices {
      if filled[index] == self.space {
        filled[index] = fill
        fill = (fill == self.c) ? self.j : self.c
      }
    }
    return (filled, self.calculateCost(filled))
  }
  
  private func calculateCost(_ piece: [Character]) -> Int {
    var cost = 0
    for index in 0 ..< piece.count - 1 {
      if piece[index] == self.c && piece[index + 1] == self.j {
        cost += cjCost
      } else if piece[index] == self.j && piece[index + 1] == self.c {
        cost += jcCost
      }
    }
    return cost
  }
}

typealias Solution = CodyJamal

func start() {
  let count = Int(readLine()!)!
  for index in 1 ... count {
    let solution = Solution()
    print("Case #\(index): \(solution.output())")
  }
}

//start()

struct Test {
  var input: String
  var expected: String
}

let tests: Array<Test> = [
  Test(input: "2 3 CJ?CC?", expected: "5"),
  Test(input: "4 2 CJCJ", expected: "10"),
  Test(input: "1 3 C?J", expected: "1"),
  Test(input: "2 5 ??J???", expected: "0"),
  Test(input: "2 -5 ??JJ??", expected: "-8"),
]

tests.forEach {
  let output = Solution(input: $0.input).output()
  if $0.expected == output {
    print("✅ input: \($0.input), output: \(output)")
  } else {
    print("❗️ input: \($0.input), expected: \($0.expected), actually: \(output)")
  }
}
