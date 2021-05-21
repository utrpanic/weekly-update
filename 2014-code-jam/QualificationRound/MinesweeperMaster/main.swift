
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
        self.setMinesPhase1()
        if self.numberOfMines % 2 == 1 {
            return "Impossible"
        }
        self.setMinesPhase2()
        self.clickBottomRightCell()
        if self.cellsContainUnknown() {
            return "Impossible"
        } else {
            return self.printCells()
        }
    }
    
    private func setMinesPhase1() {
        let rowIteration = self.numberOfRows > 2 ? self.numberOfRows - 2 : self.numberOfRows
        let columnIteration = self.numberOfColumns > 2 ? self.numberOfColumns - 2 : self.numberOfColumns
        for row in 0 ..< rowIteration {
            for column in 0 ..< columnIteration {
                if self.numberOfMines > 0 {
                    self.cells[row][column] = .mine
                    self.numberOfMines -= 1
                }
            }
        }
    }
    
    private func setMinesPhase2() {
        if self.numberOfRows > 2 {
            for row in 0 ..< self.numberOfRows - 2 {
                for column in 0 ..< self.numberOfColumns {
                    if case .unknown = self.cells[row][column], self.numberOfMines > 0 {
                        self.cells[row][column] = .mine
                        self.numberOfMines -= 1
                    }
                }
            }
        }
        for column in 0 ..< self.numberOfColumns {
            for row in 0 ..< self.numberOfRows {
                if case .unknown = self.cells[row][column], self.numberOfMines > 0 {
                    self.cells[row][column] = .mine
                    self.numberOfMines -= 1
                }
            }
        }
    }
    
    private func clickBottomRightCell() {
        let clickRow = self.cells.count - 1
        let clickColumn = self.cells[clickRow].count - 1
        defer {
            self.cells[clickRow][clickColumn] = .click
        }
        for row in (0 ..< self.cells.count).reversed() {
            for column in (0 ..< self.cells[row].count).reversed() {
                switch self.cells[row][column] {
                case .mine:
                    break
                default:
                    let count = self.adjacentCount(row: row, column: column)
                    if row == clickRow && column == clickColumn && count > 0 {
                        return
                    } else {
                        self.cells[row][column] = .adjacent(count)
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
    
    private func cellCanOpen(row: Int, column: Int) -> Bool {
        if case let .adjacent(count) = self.cells[row][column], count == 0 {
            return true
        }
        if row + 1 < self.cells.count && 0 <= column - 1 {
            if case let .adjacent(count) = self.cells[row + 1][column - 1], count == 0 {
                return true
            }
        }
        if row + 1 < self.cells.count {
            if case let .adjacent(count) = self.cells[row + 1][column], count == 0 {
                return true
            }
        }
        if row + 1 < self.cells.count && column + 1 < self.cells[row + 1].count {
            if case let .adjacent(count) = self.cells[row + 1][column + 1], count == 0 {
                return true
            }
        }
        
        if column + 1 < self.cells[row].count {
            if case let .adjacent(count) = self.cells[row][column + 1], count == 0 {
                return true
            }
        }
        return false
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
    
    private func printCells() -> String {
        var result = ""
        for row in 0 ..< self.cells.count {
            let cellsInRow = self.cells[row].map { $0.print }
            result.append(cellsInRow.joined())
            result.append("\n")
        }
        return result
    }
}

typealias Solution = MinesweeperMaster

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
    Test(input: "5 5 23", expected: """
        Impossible
        """),
    Test(input: "3 1 1", expected: """
        c
        .
        *
        """),
    Test(input: "1 3 1", expected: """
        *.c
        """),
    Test(input: "4 4 5", expected: """
        Impossible
        """),
    Test(input: "2 2 1", expected: """
        Impossible
        """),
    Test(input: "4 7 3", expected: """
        ......*
        .c....*
        .......
        ..*....
        """),
    Test(input: "10 10 82", expected: """
        **********
        **********
        **********
        ****....**
        ***.....**
        ***.c...**
        ***....***
        **********
        **********
        **********
        """),
]

tests.forEach({
    let expected = $0.expected == "Impossible" ? "Impossible" : "Possible"
    print("✅ input: \($0.input), expected: \(expected)")
    let output = Solution(input: $0.input).output()
    print("\(output)")
})
