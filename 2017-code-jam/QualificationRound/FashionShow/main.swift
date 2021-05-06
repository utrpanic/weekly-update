
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
                case .plus:
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
    
    struct Position: Hashable {
        let row: Int
        let column: Int
        init(_ row: Int, _ column: Int) {
            self.row = row
            self.column = column
        }
    }
    
    private mutating func solveBishopsProblem() {
        let size = self.bishops.count
        var leftTop = Set<Position>()
        var rightTop = Set<Position>()
        var leftBottom = Set<Position>()
        var rightBottom = Set<Position>()
        for index in 0 ..< size {
            if index == 0 {
                leftTop.insert(Position(0, 0))
                rightTop.insert(Position(0, size - 1))
                leftBottom.insert(Position(size - 1, 0))
                rightBottom.insert(Position(size - 1, size - 1))
            } else {
                var newLeftTop = Set<Position>()
                var newRightTop = Set<Position>()
                var newLeftBottom = Set<Position>()
                var newRightBottom = Set<Position>()
                leftTop.forEach { position in
                    newLeftTop.insert(Position(position.row + 1, position.column))
                    newLeftTop.insert(Position(position.row, position.column + 1))
                }
                rightTop.forEach { position in
                    newRightTop.insert(Position(position.row + 1, position.column))
                    newRightTop.insert(Position(position.row, position.column - 1))
                }
                leftBottom.forEach { position in
                    newLeftBottom.insert(Position(position.row - 1, position.column))
                    newLeftBottom.insert(Position(position.row, position.column + 1))
                }
                rightBottom.forEach { position in
                    newRightBottom.insert(Position(position.row - 1, position.column))
                    newRightBottom.insert(Position(position.row, position.column - 1))
                }
                leftTop = newLeftTop
                rightTop = newRightTop
                leftBottom = newLeftBottom
                rightBottom = newRightBottom
            }
            [leftTop, rightTop, leftBottom, rightBottom].forEach { positions in
                positions.forEach { position in
                    guard 0 <= position.row && position.row < size else { return }
                    guard 0 <= position.column && position.column < size else { return }
                    if self.bishops[position.row][position.column] == .plus {
                        // do nothing
                    } else {
                        if !self.diagonalContainsPlus(cells: self.bishops, row: position.row, column: position.column) {
                            self.bishops[position.row][position.column] = .plus
                        }
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
    Test(input: (5, ["+ 2 2", "+ 2 4", "+ 4 1"]), expected: 12),
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
