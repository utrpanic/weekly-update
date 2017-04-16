//
//  HouseOfPancakes.swift
//  1-qualification-round
//
//  Created by gurren-l on 2017. 4. 16..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

class HouseOfPancakes {
    
    private var time: Int
    private var pancakes: Array<Int>
    
    init(input: String) {
        self.time = 0
        var inputs = input.components(separatedBy: " ").filter({ !$0.isEmpty })
        inputs.removeFirst()
        self.pancakes = inputs.flatMap({ Int($0) })
    }
    
    func output() -> String {
        var max: Int = 0
        var maxIndex: Int = 0
        var countOfMax: Int = 0
        for index in 0 ..< self.pancakes.count {
            if self.pancakes[index] > max {
                max = self.pancakes[index]
                maxIndex = index
                countOfMax = 1
            } else if self.pancakes[index] == max {
                countOfMax += 1
            }
        }
        let currentSolution = self.time + max
        if countOfMax <= max / 2 {
            self.time += 1
            self.pancakes[maxIndex] = max / 2
            self.pancakes.append(max - (max / 2))
            return String(min(currentSolution, Int(self.output())!))
        } else {
            return String(currentSolution)
        }
    }
    
}

