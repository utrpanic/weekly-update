
enum Model: String {
    
    case none = "."
    case plus = "+"
    case x = "x"
    case o = "o"
    
    var point: Int {
        switch self {
        case .none: return 0
        case .plus, .x: return 1
        case .o: return 2
        }
    }
}

struct FashionShow {
    
    var originalCells: [[Model]] = []
    var rooks: [[Model]] = []
    var bishops: [[Model]] = []
    
    init() {
        let input = readLine()!.split(separator: " ").map { Int($0)! }
        let gridSize = input[0]
        let modelCount = input[1]
        var models: [String] = []
        for _ in 0 ..< modelCount {
            models.append(readLine()!)
        }
        self.init(input: (gridSize: gridSize, models: models))
    }
    
    init(input: (gridSize: Int, models: [String])) {
        for _ in 0 ..< input.gridSize {
            self.originalCells.append(Array<Model>(repeating: .none, count: input.gridSize))
            self.rooks.append(Array<Model>(repeating: .none, count: input.gridSize))
            self.bishops.append(Array<Model>(repeating: .none, count: input.gridSize))
        }
        input.models.forEach {
            self.applyModel(input: $0)
        }
        for row in 0 ..< self.originalCells.count {
            for column in 0 ..< self.originalCells[row].count {
                switch self.originalCells[row][column] {
                case .o:
                    self.rooks[row][column] = .x
                    self.bishops[row][column] = .plus
                case .x:
                    self.rooks[row][column] = .x
                    self.bishops[row][column] = .none
                case .plus:
                    self.rooks[row][column] = .none
                    self.bishops[row][column] = .plus
                case .none:
                    break
                }
            }
        }
    }
    
    mutating func applyModel(input: String) {
        let inputs = input.split(separator: " ")
        let model = Model(rawValue: String(inputs[0]))!
        let row = Int(inputs[1])! - 1
        let col = Int(inputs[2])! - 1
        self.originalCells[row][col] = model
    }
    
    mutating func output() -> (point: Int, models: [String]) {
        self.solveRooksProblem()
        self.solveBishopsProblem()
        let results = self.mergeRooksAndBishops()
        var point = 0
        var models: [String] = []
        for row in 0 ..< results.count {
            for column in 0 ..< results[row].count {
                let result = results[row][column]
                if self.originalCells[row][column] != result {
                    models.append("\(result.rawValue) \(row + 1) \(column + 1)")
                }
                point += result.point
            }
        }
        return (point, models)
    }
    
    private mutating func solveRooksProblem() {
        for row in 0 ..< self.rooks.count {
            for column in 0 ..< self.rooks[row].count {
                if self.rooks[row][column] == .x {
                    continue
                } else {
                    if !self.rowContainsX(cells: self.rooks, row: row) && !self.columnContainsX(cells: self.rooks, column: column) {
                        self.rooks[row][column] = .x
                    }
                }
            }
        }
    }
    
    private func rowContainsX(cells: [[Model]], row: Int) -> Bool {
        return cells[row].contains(.x)
    }
    
    private func columnContainsX(cells: [[Model]], column: Int) -> Bool {
        for index in 0 ..< cells.count {
            if cells[index][column] == .x {
                return true
            }
        }
        return false
    }
    
    private mutating func solveBishopsProblem() {
        for row in 0 ..< self.bishops.count {
            for column in 0 ..< self.bishops[row].count {
                if self.bishops[row][column] == .plus {
                    continue
                } else {
                    if !self.diagonalContainsPlus(cells: self.bishops, row: row, column: column) {
                        self.bishops[row][column] = .plus
                    }
                }
            }
        }
    }
    
    private func diagonalContainsPlus(cells: [[Model]], row: Int, column: Int) -> Bool {
        for index in 0 ..< cells.count {
            if index == 0 {
                continue
            }
            if row - index >= 0 && column - index >= 0 {
                if cells[row-index][column-index] == .plus {
                    return true
                }
            }
            if row + index < cells.count && column + index < cells[row].count {
                if cells[row+index][column+index] == .plus {
                    return true
                }
            }
            if row - index >= 0 && column + index < cells[row].count {
                if cells[row-index][column+index] == .plus {
                    return true
                }
            }
            if row + index < cells.count && column - index >= 0 {
                if cells[row+index][column-index] == .plus {
                    return true
                }
            }
        }
        return false
    }
    
    private func mergeRooksAndBishops() -> [[Model]] {
        var results = self.originalCells
        for row in 0 ..< results.count {
            for column in 0 ..< results[row].count {
                switch (self.rooks[row][column], self.bishops[row][column]) {
                case (.x, .plus):
                    results[row][column] = .o
                case (.x, _):
                    results[row][column] = .x
                case (_, .plus):
                    results[row][column] = .plus
                default:
                    results[row][column] = .none
                }
            }
        }
        return results
    }
}

func start() {
    let count = Int(readLine()!)!
    for index in 1 ... count {
        var solution = FashionShow()
        let result = solution.output()
        print("Case #\(index): \(result.point) \(result.models.count)")
        result.models.forEach {
            print($0)
        }
    }
}

//start()

struct Test {
    var input: (Int, [String])
    var expected: Int
}

func == (lhs: (Int, [String]), rhs: (Int, [String])) -> Bool {
    return lhs.0 == rhs.0
}

extension FashionShow {
    
    var point: Int {
        var sum = 0
        self.originalCells.forEach { cells in
            cells.forEach { cell in
                sum += cell.point
            }
        }
        return sum
    }
}

let tests: Array<Test> = [
    Test(input: (2, []), expected: 4),
    Test(input: (1, ["o 1 1"]), expected: 2),
    Test(input: (3, ["+ 2 3", "+ 2 1", "x 3 1", "+ 2 2"]), expected: 6),
]

tests.forEach({
    var input = FashionShow(input: $0.input)
    var solution = input
    let output = solution.output()
    output.models.forEach {
        input.applyModel(input: $0)
    }
    if $0.expected == output.point && $0.expected == input.point {
        print("✅ input: \($0.input), expected: \($0.expected)")
//        output.models.forEach { model in
//            print(model)
//        }
    } else {
        print("❗️ input: \($0.input)")
        print("expected: \($0.expected)")
        print("actually: \(output.point)")
        output.models.forEach { model in
            print(model)
        }
    }
})
