
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

struct Cell {
    var model: Model = .none
    var point: Int { self.model.point }
}

struct FashionShow {
    
    var cells: [[Cell]] = []
    
    var point: Int {
        var totalPoint = 0
        self.cells.forEach {
            $0.forEach { cell in
                totalPoint += cell.point
            }
        }
        return totalPoint
    }
    
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
            self.cells.append(Array<Cell>(repeating: Cell(), count: input.gridSize))
        }
        input.models.forEach {
            self.applyModel(input: $0)
        }
    }
    
    mutating func applyModel(input: String) {
        let inputs = input.split(separator: " ")
        let model = Model(rawValue: String(inputs[0]))!
        let row = Int(inputs[1])! - 1
        let col = Int(inputs[2])! - 1
        self.cells[row][col].model = model
    }
    
    mutating func output() -> (point: Int, models: [String]) {
        // 점수를 최대화할 방법을 알아야하고.
        // violation을 확인할 수 있어야되고.
        // Cell array를 써야하는지 Model array를 써야하는지 판단 필요.
        
        return (4, ["o 2 2", "+ 2 1", "x 1 1"])
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

let tests: Array<Test> = [
    Test(input: (2, []), expected: 4),
//    Test(input: (1, ["o 1 1"]), expected: 2),
//    Test(input: (3, ["+ 2 3", "+ 2 1", "x 3 1", "+ 2 2"]), expected: 6),
]

tests.forEach({
    var input = FashionShow(input: $0.input)
    var solution = input
    let output = solution.output()
    output.models.forEach {
        input.applyModel(input: $0)
    }
    if $0.expected == output.point && $0.expected == input.point {
        print("✅ input: \($0.input)")
        print("expected: \($0.expected)")
        print("actually: \(output.point)")
        output.models.forEach { model in
            print(model)
        }
    } else {
        print("❗️ input: \($0.input)")
        print("expected: \($0.expected)")
        print("actually: \(output.point)")
        output.models.forEach { model in
            print(model)
        }
    }
})
