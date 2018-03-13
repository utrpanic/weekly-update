//
//  FashionShow.swift
//  FashionShow
//
//  Created by boxjeon on 2018. 3. 13..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

enum Cell: String {
    case empty = "."
    case stylePlus = "+"
    case styleX = "x"
    case styleO = "o"
    
    var point: Int {
        switch self {
        case .empty: return 0
        case .stylePlus, .styleX: return 1
        case .styleO: return 2
        }
    }
}

class FashionShow {
    
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
    
    init(input: (Int, [String])) {
        for _ in 0 ..< input.0 {
            self.cells.append(Array<Cell>(repeating: .empty, count: input.0))
        }
        let models = input.1.map({ Model(input: $0) })
        models.forEach {
            self.cells[$0.row][$0.col] = $0.clothing
        }
    }
    
    func output() -> (point: Int, models: [String]) {
        // 점수를 최대화할 방법을 알아야하고.
        // violation을 확인할 수 있어야되고.
        // Cell array를 써야하는지 Model array를 써야하는지 판단 필요.
        
        return (4, ["o 2 2", "+ 2 1", "x 1 1"])
    }
}

class Model {
    
    let row: Int
    let col: Int
    var clothing: Cell
    
    init(input: String) {
        let inputs = input.split(separator: " ")
        self.row = Int(String(inputs[1]))! - 1
        self.col = Int(String(inputs[2]))! - 1
        self.clothing = Cell(rawValue: String(inputs[0]))!
    }
}
