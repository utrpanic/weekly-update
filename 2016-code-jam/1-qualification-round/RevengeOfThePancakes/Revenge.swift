//
//  Revenge.swift
//  1-qualification-round
//
//  Created by boxjeon on 2017. 4. 16..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

enum Pancake: String {
    case happy = "+"
    case blank = "-"
    func flip() -> Pancake {
        switch self {
        case .happy:
            return .blank
        case .blank:
            return .happy
        }
    }
}

class Revenge {
    
    private var pancakes: Array<Pancake>
    
    init(input: String) {
        self.pancakes = input.characters.flatMap({ Pancake(rawValue: String($0)) })
    }
    
    func output() -> String {
        var flipCount = 0
        while !self.pancakes.reduce(true, { $0 && ($1 == .happy) }) {
            for index in (0 ..< self.pancakes.count).reversed() {
                if case .happy = self.pancakes[index] {
                    self.pancakes.remove(at: index)
                } else {
                    break
                }
            }
            if case .happy = self.pancakes.first! {
                for index in (0 ..< self.pancakes.count).reversed() {
                    if case .happy = self.pancakes[index] {
                        self.pancakes = self.flipPancakes(to: index)
                        flipCount += 1
                        break
                    }
                }
            } else if case .blank = self.pancakes.first! {
                for index in (0 ..< self.pancakes.count).reversed() {
                    if case .blank = self.pancakes[index] {
                        self.pancakes = self.flipPancakes(to: index)
                        flipCount += 1
                        break
                    }
                }
            }
        }
        return String(flipCount)
    }
    
    private func flipPancakes(to: Int) -> Array<Pancake> {
        var flippedPancakes = Array<Pancake>()
        for index in (0 ... to).reversed() {
            flippedPancakes.append(self.pancakes[index].flip())
        }
        for index in (to + 1) ..< self.pancakes.count {
            flippedPancakes.append(self.pancakes[index])
        }
        return flippedPancakes
    }
    
}
