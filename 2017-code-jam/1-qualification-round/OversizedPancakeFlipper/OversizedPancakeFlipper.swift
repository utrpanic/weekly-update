//
//  OversizedPancakeFlipper.swift
//  OversizedPancakeFlipper
//
//  Created by boxjeon on 2018. 3. 10..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

import Foundation

enum Pancake: Character {
    case happy = "+"
    case blank = "-"
    
    mutating func flip() {
        switch self {
        case .happy: self = .blank
        case .blank: self = .happy
        }
    }
}

class OversizedPancakeFlipper {
    
    var pancakes: [Pancake]
    let fliperSize: Int
    
    var isHappy: Bool { return !self.pancakes.contains(.blank) }
    
    init(input: String) {
        let inputs = input.split(separator: " ")
        self.pancakes = String(inputs[0]).flatMap({ Pancake(rawValue: $0) })
        self.fliperSize = Int(String(inputs[1]))!
    }
    
    func output() -> String {
        var flipCount = 0
        for index in 0 ..< self.pancakes.count {
            switch self.pancakes[index] {
            case .happy:
                continue
            case .blank:
                self.flip(at: index)
                flipCount += 1
            }
        }
        return self.isHappy ? String(flipCount) : "IMPOSSIBLE"
        
    }

    private func flip(at startIndex: Int) {
        guard startIndex + self.fliperSize <= self.pancakes.count else { return }
        for index in startIndex ..< self.pancakes.count {
            if index < startIndex + self.fliperSize {
                self.pancakes[index].flip()
            } else {
                break
            }
        }
    }
}
