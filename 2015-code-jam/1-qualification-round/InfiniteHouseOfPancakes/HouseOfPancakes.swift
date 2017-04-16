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
        self.pancakes.sort()
        let max = self.pancakes.last!
        let countOfMax = pancakes.reduce(0, {
            return $0 + ($1 == max ? 1 : 0)
        })
        if countOfMax <= max / 2 {
            self.time += 1
            self.pancakes.removeLast()
            self.pancakes.append(max / 2)
            self.pancakes.append(max - (max / 2))
            return self.output()
        } else {
            return String(self.time + max)
        }
    }
    
}

