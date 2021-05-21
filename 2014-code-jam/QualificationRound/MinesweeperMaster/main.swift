
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
    let numberOfMines: Int
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
        self.clickCell()
        if self.cellsContainUnknown() {
            return "Impossible"
        } else {
            return self.printCells()
        }
    }
    
    private func setMines() {
        var mines = self.numberOfMines
        let numberOfIteration = min(self.numberOfRows, self.numberOfColumns)
        for index in 0 ..< numberOfIteration {
            let minesInRow: Int
            if mines >= self.numberOfColumns - index {
                minesInRow = self.numberOfColumns - index
            } else {
                if mines == self.numberOfColumns - index - 1 && index < numberOfIteration - 2 {
                    minesInRow = self.numberOfColumns - index - 2
                } else {
                    minesInRow = mines
                }
            }
            for column in index ..< index + minesInRow {
                self.cells[index][column] = .mine
            }
            mines -= minesInRow
            if mines == 0 { break }
            
            mines += 1
            let minesInColumn: Int
            if mines >= self.numberOfRows - index {
                minesInColumn = self.numberOfRows - index
            } else {
                if mines == self.numberOfRows - index - 1 && index < numberOfIteration - 2 {
                    minesInColumn = self.numberOfRows - index - 2
                } else {
                    minesInColumn = mines
                }
            }
            for row in index ..< index + minesInColumn {
                self.cells[row][index] = .mine
            }
            mines -= minesInColumn
            if mines == 0 { break }
        }
    }
    
    private func clickCell() {
        for row in (0 ..< self.cells.count).reversed() {
            for column in (0 ..< self.cells[row].count).reversed() {
                if case .mine = self.cells[row][column] {
                    break
                } else {
                    self.cells[row][column] = .adjacent(self.adjacentCount(row: row, column: column))
                    if self.cellCanOpen(row: row, column: column) {
                        continue
                    } else {
                        break
                    }
                }
            }
        }
        let lastRow = self.cells.count - 1
        let lastColumn = self.cells[lastRow].count - 1
        self.cells[lastRow][lastColumn] = .click
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
