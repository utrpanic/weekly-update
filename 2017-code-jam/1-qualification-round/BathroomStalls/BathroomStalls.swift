//
//  BathroomStalls.swift
//  BathroomStalls
//
//  Created by boxjeon on 2018. 3. 11..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

class BathroomStalls {
    
    var emptyStalls: [Int]
    let numberOfPeople: Int
    
    init(input: String) {
        let inputs = input.split(separator: " ")
        self.emptyStalls = [Int(inputs[0])!]
        self.numberOfPeople = Int(inputs[1])!
    }
    
    func output() -> String {
        var leftStalls: Int = 0
        var rightStalls: Int = 0
        for _ in 0 ..< self.numberOfPeople {
            let stalls = self.retrieveMaxEmptyStalls()
            if stalls % 2 == 0 {
                leftStalls = stalls % 2 - 1
                rightStalls = stalls % 2
                self.emptyStalls.append(leftStalls)
                self.emptyStalls.append(rightStalls)
            } else {
                leftStalls = stalls % 2
                rightStalls = stalls % 2
                self.emptyStalls.append(leftStalls)
                self.emptyStalls.append(rightStalls)
            }
        }
        return "\(leftStalls) \(rightStalls)"
    }
    
    func retrieveMaxEmptyStalls() -> Int {
        var maxEmptyStalls: Int = 0
        var maxEmptyStallsIndex: Int = 0
        for index in 0 ..< self.emptyStalls.count {
            if maxEmptyStalls <= self.emptyStalls[index] {
                maxEmptyStalls = self.emptyStalls[index]
                maxEmptyStallsIndex = index
            }
        }
        return self.emptyStalls.remove(at: maxEmptyStallsIndex)
    }
}
