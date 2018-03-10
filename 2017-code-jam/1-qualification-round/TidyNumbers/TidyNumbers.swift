//
//  TidyNumbers.swift
//  TidyNumbers
//
//  Created by boxjeon on 2018. 3. 10..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

import Foundation

enum Digit: Character {
    case _0 = "0"
    case _1 = "1"
    case _2 = "2"
    case _3 = "3"
    case _4 = "4"
    case _5 = "5"
    case _6 = "6"
    case _7 = "7"
    case _8 = "8"
    case _9 = "9"
    
    mutating func decrease() {
        let newRawValue = Character(String(Int(String(self.rawValue))! - 1))
        self = Digit(rawValue: newRawValue)!
    }
}

func < (_ lhs: Digit, _ rhs: Digit) -> Bool {
    return Int(String(lhs.rawValue))! < Int(String(rhs.rawValue))!
}

class TidyNumbers {
    
    var number: [Digit]
    
    init(input: String) {
        self.number = input.flatMap({ Digit(rawValue: $0) })
    }
    
    func output() -> String {
        for index in (1 ..< self.number.count).reversed() {
            if self.number[index] < self.number[index - 1] {
                self.fill9(from: index)
                self.number[index - 1].decrease()
            }
        }
        if self.number[0] == ._0 {
            self.number.removeFirst()
        }
        return self.number.map({ String($0.rawValue) }).joined()
    }
    
    func fill9(from: Int) {
        for index in from ..< self.number.count {
            self.number[index] = ._9
        }
    }
}
