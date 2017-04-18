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
    
    private func optimalNumberOfCakePerPlate(numberOfPancake: Int) -> Int {
        var minimumTime = numberOfPancake
        for numberOfCakePerPlate in 1 ..< numberOfPancake {
            let neededSpecialTime = ((numberOfPancake + (numberOfCakePerPlate - 1)) / numberOfCakePerPlate) - 1
            let neededDiningTime = numberOfCakePerPlate
            if minimumTime >= neededSpecialTime + neededDiningTime {
                minimumTime = neededSpecialTime + neededDiningTime
            } else {
                return numberOfCakePerPlate - 1
            }
        }
        return numberOfPancake
    }
    
    private func dining(pancakes: Array<Int>, elapsedTime: Int) -> Int {
        let optimalSet = Set(pancakes.map({ self.optimalNumberOfCakePerPlate(numberOfPancake: $0) }))
        let minimum = optimalSet.reduce(1000) { (minimum, maxPancakesPerPlate) -> Int in
            var specialTime = 0
            for index in (0 ..< pancakes.count).reversed() {
                let divider = pancakes[index] / maxPancakesPerPlate
                let remainder = pancakes[index] % maxPancakesPerPlate
                if divider > 0 {
                    specialTime += divider - 1
                    if remainder > 0 {
                        specialTime += 1
                    }
                }
            }
            print("max cakes per plate: \(maxPancakesPerPlate), elapsed time: \(specialTime + maxPancakesPerPlate)")
            return min(minimum, specialTime + maxPancakesPerPlate)
        }
        return minimum
    }
    
}

