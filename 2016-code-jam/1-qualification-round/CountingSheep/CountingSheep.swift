//
//  CountingSheep.swift
//  1-qualification-round
//
//  Created by boxjeon on 2017. 4. 16..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

class CountingSheep {
    
    class var insomnia: String { return "INSOMNIA" }
    
    private var firstNumber: String
    private var checkBoxes: Array<Bool>
    
    init(input: String) {
        self.firstNumber = input
        self.checkBoxes = Array<Bool>(repeating: false, count: 10)
    }
    
    func output() -> String {
        guard Int(self.firstNumber) ?? 0 > 0 else {
            return CountingSheep.insomnia
        }
        
        var currentNumber = self.firstNumber
        
        repeat {
            self.checkNewNumber(currentNumber)
            if self.checkInSleep() {
                return currentNumber
            }
            currentNumber = String(Int(currentNumber)! + Int(self.firstNumber)!)
        } while currentNumber.characters.count < self.firstNumber.characters.count + 2
        
        return CountingSheep.insomnia
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
