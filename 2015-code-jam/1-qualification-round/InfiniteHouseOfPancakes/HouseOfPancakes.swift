//
//  HouseOfPancakes.swift
//  1-qualification-round
//
//  Created by boxjeon on 2017. 4. 16..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

class HouseOfPancakes {
    
    private var pancakes: Array<Int>
    
    init(input: String) {
        var inputs = input.components(separatedBy: " ").filter({ !$0.isEmpty })
        inputs.removeFirst()
        self.pancakes = inputs.flatMap({ Int($0) })
    }
    
    func output() -> String {
        let max = self.pancakes.reduce(-1, { $0 < $1 ? $1 : $0 })
        var minimumElapsedTime: Int = max
        for maxPancakesPerPlate in 1 ..< max {
            var specialTime = 0
            for index in 0 ..< self.pancakes.count {
                if self.pancakes[index] > maxPancakesPerPlate {
                    specialTime += (self.pancakes[index] + (maxPancakesPerPlate - 1)) / maxPancakesPerPlate
                    specialTime -= 1
                }
            }
            minimumElapsedTime = min(specialTime + maxPancakesPerPlate, minimumElapsedTime)
        }
        return String(minimumElapsedTime)
    }
    
}

