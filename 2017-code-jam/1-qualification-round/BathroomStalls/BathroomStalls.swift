//
//  BathroomStalls.swift
//  BathroomStalls
//
//  Created by boxjeon on 2018. 3. 11..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

class BathroomStalls {
    var emptyStalls: [(Int, Int)]
    let numberOfPeople: Int
    
    init(input: String) {
        let inputs = input.split(separator: " ")
        self.emptyStalls = [(Int(inputs[0])!, 1)]
        self.numberOfPeople = Int(inputs[1])!
    }
    
    func output() -> String {
        var waitingPeople = self.numberOfPeople
        while waitingPeople > self.emptyStalls[0].1 {
            let stalls = self.emptyStalls.removeFirst()
            let (large, small) = self.retrieveLargeSmallStalls(stalls.0)
            self.insertEmptyStalls(large, count: stalls.1)
            self.insertEmptyStalls(small, count: stalls.1)
            waitingPeople -= stalls.1
        }
        let stalls = self.emptyStalls.removeFirst().0
        let (large, small) = self.retrieveLargeSmallStalls(stalls)
        return "\(large) \(small)"
    }
    
    func insertEmptyStalls(_ emptyStalls: Int, count: Int) {
        guard emptyStalls > 0 else { return }
        if self.emptyStalls.contains(where: { $0.0 == emptyStalls }) {
            for index in 0 ..< self.emptyStalls.count {
                if self.emptyStalls[index].0 == emptyStalls {
                    self.emptyStalls[index].1 += count
                    break
                }
            }
        } else {
            self.emptyStalls.append((emptyStalls, count))
        }
    }
    
    func retrieveLargeSmallStalls(_ emptyStalls: Int) -> (large: Int, small: Int) {
        let largeStalls: Int = emptyStalls / 2
        let smallStalls: Int = emptyStalls % 2 == 0 ? max(0, largeStalls - 1) : largeStalls
        return (large: largeStalls, small: smallStalls)
    }
}
