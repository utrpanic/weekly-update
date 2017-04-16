//
//  CountingSheep.swift
//  1-qualification-round
//
//  Created by gurren-l on 2017. 4. 16..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

enum Finally {
    case sleep(lastNumber: Int)
    case insomnia
    var text: String {
        switch self {
        case .sleep(let lastNumber):
            return String(lastNumber)
        case .insomnia:
            return "INSOMNIA"
        }
    }
}

class CountingSheep {
    
    private var firstNumber: String
    private var checkBoxes: Array<Bool>
    
    init(firstNumber: Int) {
        self.firstNumber = String(firstNumber)
        self.checkBoxes = Array<Bool>(repeating: false, count: 10)
    }
    
    func startToSleep() -> Finally {
        guard Int(self.firstNumber) ?? 0 > 0 else {
            return .insomnia
        }
        
        var currentNumber = self.firstNumber
        
        repeat {
            self.checkNewNumber(currentNumber)
            if self.checkInSleep() {
                return .sleep(lastNumber: Int(currentNumber)!)
            }
            currentNumber = String(Int(currentNumber)! + Int(self.firstNumber)!)
        } while currentNumber.characters.count < self.firstNumber.characters.count + 2
        
        return .insomnia
    }
    
    private func checkNewNumber(_ number: String) {
        number.characters.forEach( {
            if let digit = Int(String($0)) {
                self.checkBoxes[digit] = true
            }
        })
    }
    
    private func checkInSleep() -> Bool {
        return self.checkBoxes.reduce(true, { $0 && $1 })
    }
    
}
