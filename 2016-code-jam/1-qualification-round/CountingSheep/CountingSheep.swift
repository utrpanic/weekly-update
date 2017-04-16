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
            return "\(lastNumber)"
        case .insomnia:
            return "INSOMNIA"
        }
    }
}

class CountingSheep {
    
    private var firstNumber: Int
    private var checkBoxes: Array<Bool>
    
    init(firstNumber: Int) {
        self.firstNumber = firstNumber
        self.checkBoxes = Array<Bool>(repeating: false, count: 10)
    }
    
    func startToSleep() -> Finally {
        var currentNumber = self.firstNumber
        while true {
            self.checkNewNumber(currentNumber)
            if self.checkInSleep() {
                return .sleep(lastNumber: currentNumber)
            } else {
                currentNumber += self.firstNumber
            }
        }
    }
    
    private func checkNewNumber(_ number: Int) {
        var newNumber = number
        while newNumber > 0 {
            self.checkBoxes[newNumber % 10] = true
            newNumber /= 10
        }
    }
    
    private func checkInSleep() -> Bool {
        return self.checkBoxes.reduce(true, { $0 && $1 })
    }
    
}

