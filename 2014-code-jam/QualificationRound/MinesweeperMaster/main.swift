
enum Cell {
    case unknown
    case mine
    case adjacent(Int)
    case click
    
    var print: String {
        switch self {
        case .unknown: return " "
        case .mine: return "*"
        case .adjacent: return "."
        case .click: return "c"
        }
    }
}

class MinesweeperMaster {
    
    let numberOfRows: Int
    let numberOfColumns: Int
    var numberOfMines: Int
    var cells: [[Cell]]
    
    convenience init() {
        self.init(input: readLine()!)
    }
    
    init(input: String) {
        let inputs = input.split(separator: " ").map { Int($0)! }
        self.numberOfRows = inputs[0]
        self.numberOfColumns = inputs[1]
        self.numberOfMines = inputs[2]
        self.cells = []
        for _ in 0 ..< self.numberOfRows {
            self.cells.append(Array<Cell>(repeating: .unknown, count: self.numberOfColumns))
        }
    }
    
    func output() -> String {
        self.setMines()
        self.clickBottomRightCell()
        if self.cellsContainUnknown() {
            return "Impossible"
        } else {
            return self.printCells()
        }
    }
    
    private func setMines() {
        if self.numberOfRows <= 2 {
            for column in 0 ..< self.numberOfColumns {
                for row in 0 ..< self.numberOfRows {
                    self.setMineAt(row: row, column: column)
                }
            }
        } else if self.numberOfColumns <= 2 {
            for row in 0 ..< self.numberOfRows {
                for column in 0 ..< self.numberOfColumns {
                    self.setMineAt(row: row, column: column)
                }
            }
        } else {
            let numberOfEmptyCells = self.numberOfRows * self.numberOfColumns - self.numberOfMines
            if numberOfEmptyCells >= self.numberOfColumns * 3 {
                for row in 0 ..< self.numberOfRows {
                    for column in 0 ..< self.numberOfColumns {
                        if column == self.numberOfColumns - 2 && self.numberOfMines == 1 {
                            break
                        } else {
                            self.setMineAt(row: row, column: column)
                        }
                    }
                }
            } else {
                for row in 0 ..< self.numberOfRows - 3 {
                    for column in 0 ..< self.numberOfColumns {
                        self.setMineAt(row: row, column: column)
                    }
                }
                for column in 0 ..< self.numberOfColumns - 3 {
                    for row in self.numberOfRows - 3 ..< self.numberOfRows {
                        if row == self.numberOfRows - 2 && self.numberOfMines == 1 {
                            break
                        } else {
                            self.setMineAt(row: row, column: column)
                        }
                    }
                }
                let last3x3: [[Cell]]
                switch self.numberOfMines {
                case 1:
                    last3x3 = [
                        [.mine,     .unknown,   .unknown],
                        [.unknown,  .unknown,   .unknown],
                        [.unknown,  .unknown,   .unknown]
                    ]
                case 2:
                    last3x3 = [
                        [.mine,     .mine,      .unknown],
                        [.unknown,  .unknown,   .unknown],
                        [.unknown,  .unknown,   .unknown]
                    ]
                case 3:
                    last3x3 = [
                        [.mine,     .mine,      .mine],
                        [.unknown,  .unknown,   .unknown],
                        [.unknown,  .unknown,   .unknown]
                    ]
                case 4:
                    last3x3 = [
                        [.mine,     .mine,      .mine],
                        [.mine,     .unknown,   .unknown],
                        [.unknown,  .unknown,   .unknown]
                    ]
                case 5:
                    last3x3 = [
                        [.mine,     .mine,      .mine],
                        [.mine,     .unknown,   .unknown],
                        [.mine,     .unknown,   .unknown]
                    ]
                case 6:
                    last3x3 = [
                        [.mine,     .mine,      .mine],
                        [.mine,     .mine,      .unknown],
                        [.mine,     .unknown,   .unknown]
                    ]
                case 7:
                    last3x3 = [
                        [.mine,     .mine,      .mine],
                        [.mine,     .mine,      .mine],
                        [.mine,     .unknown,   .unknown]
                    ]
                case 8:
                    last3x3 = [
                        [.mine,     .mine,      .mine],
                        [.mine,     .mine,      .mine],
                        [.mine,     .mine,      .unknown]
                    ]
                default:
                    return
                }
                let rowStart = self.numberOfRows - 3
                let columnStart = self.numberOfColumns - 3
                for row in 0 ..< last3x3.count {
                    for column in 0 ..< last3x3[row].count {
                        self.cells[rowStart + row][columnStart + column] = last3x3[row][column]
                    }
                }
            }
        }
    }
    
    private func setMineAt(row: Int, column: Int) {
        guard row < self.cells.count && column < self.cells[row].count else { return }
        guard self.numberOfMines > 0 else { return }
        if case .unknown = self.cells[row][column] {
            self.cells[row][column] = .mine
            self.numberOfMines -= 1
        }
    }
    
    private func clickBottomRightCell() {
        let clickRow = self.cells.count - 1
        let clickColumn = self.cells[clickRow].count - 1
        self.click(row: clickRow, column: clickColumn)
        self.cells[clickRow][clickColumn] = .click
    }
    
    private func click(row: Int, column: Int) {
        guard 0 <= row && row < self.numberOfRows else { return }
        guard 0 <= column && column < self.numberOfColumns else { return }
        guard case .unknown = self.cells[row][column] else { return }
        let count = self.adjacentCount(row: row, column: column)
        self.cells[row][column] = .adjacent(count)
        if count == 0 {
            for neighborRow in row - 1 ..< row + 1 {
                for neighborColumn in column - 1 ..< column + 1 {
                    if neighborRow == row && neighborColumn == column {
                        continue
                    } else {
                        self.click(row: neighborRow, column: neighborColumn)
                    }
                }
            }
        }
    }
    
    private func adjacentCount(row: Int, column: Int) -> Int {
        var adjacent = 0
        if 0 <= row - 1 && 0 <= column - 1 {
            if case .mine = self.cells[row - 1][column - 1] {
                adjacent += 1
            }
        }
        if 0 <= column - 1 {
            if case .mine = self.cells[row][column - 1] {
                adjacent += 1
            }
        }
        if 0 <= row - 1 {
            if case .mine = self.cells[row - 1][column] {
                adjacent += 1
            }
        }
        if 0 <= row - 1 && column + 1 < self.cells[row - 1].count {
            if case .mine = self.cells[row - 1][column + 1] {
                adjacent += 1
            }
        }
        return adjacent
    }
    
    private func cellsContainUnknown() -> Bool {
        for row in 0 ..< self.cells.count {
            let cellsInRow = self.cells[row]
            for column in 0 ..< cellsInRow.count {
                if case .unknown = cellsInRow[column] {
                    return true
                }
            }
        }
        return false
    }
    
    func printCells() -> String {
        var result = ""
        for row in 0 ..< self.cells.count {
            let cellsInRow = self.cells[row].map { $0.print }
            result.append(cellsInRow.joined())
            result.append("\n")
        }
        result.removeLast()
        return result
    }
}

typealias Solution = MinesweeperMaster

func start() {
    let count = Int(readLine()!)!
    for index in 1 ... count {
        let solution = Solution()
        print("Case #\(index):")
        print(solution.output())
    }
}

//start()

struct Test {
    var input: String
    var expected: String
}

let tests: Array<Test> = [
    
    Test(input: "1 1 0", expected: ""),
    Test(input: "1 2 0", expected: ""),
    Test(input: "1 2 1", expected: ""),
    Test(input: "2 1 0", expected: ""),
    Test(input: "2 1 1", expected: ""),
    Test(input: "2 2 0", expected: ""),
    Test(input: "2 2 1", expected: "Impossible"),
    Test(input: "2 2 2", expected: "Impossible"),
    Test(input: "2 2 3", expected: ""),

    Test(input: "2 3 0", expected: ""),
    Test(input: "2 3 1", expected: "Impossible"),
    Test(input: "2 3 2", expected: ""),
    Test(input: "2 3 3", expected: "Impossible"),
    Test(input: "2 3 4", expected: "Impossible"),
    Test(input: "2 3 5", expected: ""),

    Test(input: "3 2 0", expected: ""),
    Test(input: "3 2 1", expected: "Impossible"),
    Test(input: "3 2 2", expected: ""),
    Test(input: "3 2 3", expected: "Impossible"),
    Test(input: "3 2 4", expected: "Impossible"),
    Test(input: "3 2 5", expected: ""),

    Test(input: "3 3 0", expected: ""),
    Test(input: "3 3 1", expected: ""),
    Test(input: "3 3 2", expected: "Impossible"),
    Test(input: "3 3 3", expected: ""),
    Test(input: "3 3 4", expected: "Impossible"),
    Test(input: "3 3 5", expected: ""),
    Test(input: "3 3 6", expected: "Impossible"),
    Test(input: "3 3 7", expected: "Impossible"),
    Test(input: "3 3 8", expected: ""),

    Test(input: "3 4 0", expected: ""),
    Test(input: "3 4 1", expected: ""),
    Test(input: "3 4 2", expected: ""),
    Test(input: "3 4 3", expected: ""),
    Test(input: "3 4 4", expected: ""),
    Test(input: "3 4 5", expected: "Impossible"),
    Test(input: "3 4 6", expected: ""),
    Test(input: "3 4 7", expected: "Impossible"),
    Test(input: "3 4 8", expected: ""),
    Test(input: "3 4 9", expected: "Impossible"),
    Test(input: "3 4 10", expected: "Impossible"),
    Test(input: "3 4 11", expected: ""),

    Test(input: "4 3 0", expected: ""),
    Test(input: "4 3 1", expected: ""),
    Test(input: "4 3 2", expected: ""),
    Test(input: "4 3 3", expected: ""),
    Test(input: "4 3 4", expected: ""),
    Test(input: "4 3 5", expected: "Impossible"),
    Test(input: "4 3 6", expected: ""),
    Test(input: "4 3 7", expected: "Impossible"),
    Test(input: "4 3 8", expected: ""),
    Test(input: "4 3 9", expected: "Impossible"),
    Test(input: "4 3 10", expected: "Impossible"),
    Test(input: "4 3 11", expected: ""),

    Test(input: "4 4 0", expected: ""),
    Test(input: "4 4 1", expected: ""),
    Test(input: "4 4 2", expected: ""),
    Test(input: "4 4 3", expected: ""),
    Test(input: "4 4 4", expected: ""),
    Test(input: "4 4 5", expected: ""),
    Test(input: "4 4 6", expected: ""),
    Test(input: "4 4 7", expected: ""),
    Test(input: "4 4 8", expected: ""),
    Test(input: "4 4 9", expected: "Impossible"),
    Test(input: "4 4 10", expected: ""),
    Test(input: "4 4 11", expected: "Impossible"),
    Test(input: "4 4 12", expected: ""),
    Test(input: "4 4 13", expected: "Impossible"),
    Test(input: "4 4 14", expected: "Impossible"),
    Test(input: "4 4 15", expected: ""),
    
    Test(input: "4 5 0", expected: ""),
    Test(input: "4 5 1", expected: ""),
    Test(input: "4 5 2", expected: ""),
    Test(input: "4 5 3", expected: ""),
    Test(input: "4 5 4", expected: ""),
    Test(input: "4 5 5", expected: ""),
    Test(input: "4 5 6", expected: ""),
    Test(input: "4 5 7", expected: ""),
    Test(input: "4 5 8", expected: ""),
    Test(input: "4 5 9", expected: ""),
    Test(input: "4 5 10", expected: ""),
    Test(input: "4 5 11", expected: ""),
    Test(input: "4 5 12", expected: ""),
    Test(input: "4 5 13", expected: "Impossible"),
    Test(input: "4 5 14", expected: ""),
    Test(input: "4 5 15", expected: "Impossible"),
    Test(input: "4 5 16", expected: ""),
    Test(input: "4 5 17", expected: "Impossible"),
    Test(input: "4 5 18", expected: "Impossible"),
    Test(input: "4 5 19", expected: ""),

    Test(input: "4 6 11", expected: ""),
    Test(input: "4 7 3", expected: ""),
    Test(input: "5 5 23", expected: "Impossible"),
    Test(input: "10 10 82", expected: ""),
]

tests.forEach {
    let expected = $0.expected == "Impossible" ? "Impossible" : "Possible"
    let solution = Solution(input: $0.input)
    let output = solution.output()
    let emoji: String
    if expected == "Impossible" {
        if output == "Impossible" {
            emoji = "✅"
        } else {
            emoji = "❌"
        }
    } else {
        emoji = "❓"
    }
    print("\(emoji) input: \($0.input), expected: \(expected)")
    print(solution.printCells())
}
