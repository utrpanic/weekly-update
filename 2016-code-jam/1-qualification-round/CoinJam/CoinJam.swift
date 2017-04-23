//
//  CoinJam.swift
//  1-qualification-round
//
//  Created by boxjeon on 2017. 4. 20..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

import Darwin
import Foundation

class CoinJam {
    
    var digitCount: Int
    let resultCount: Int
    
    init(input: String) {
        print(input)
        let inputs = input.components(separatedBy: " ").flatMap({ Int($0) })
        self.digitCount = inputs[0]
        self.resultCount = inputs[1]
    }
    
    func output() -> String {
        let startCoin = Int(pow(Double(2), Double(self.digitCount) - 1)) + 1
        let endCoin = Int(pow(Double(2), Double(self.digitCount)))
        let maxDivisor = Int(pow(Double(10), Double((self.digitCount + 1) / 2)))
        var results = Array<String>()
        for rangeIndex in stride(from: 2, to: maxDivisor, by: 100) {
            let endDivisor = rangeIndex + 100
            for coin in stride(from: startCoin, to: endCoin, by: 2) {
                let binaryText = String(coin, radix: 2)
                let binaryArray = binaryText.characters.flatMap({ Int(String($0)) })
                var result = binaryText
                for base in 2 ... 10 {
                    if let nontrivialDivisor = self.getNontrivialDivisor(binaryArray: binaryArray, base: base, end: endDivisor) {
                        result.append(" \(nontrivialDivisor)")
                    } else {
                        result = ""
                        break
                    }
                }
                if !result.isEmpty {
                    results.append("\(result)")
                }
                if results.count == self.resultCount {
                    break
                }
            }
            if results.count == self.resultCount {
                break
            } else {
                results.removeAll()
            }
        }
        return results.joined(separator: "\n")
    }
    
    private func getNontrivialDivisor(binaryArray: Array<Int>, base: Int, end: Int) -> Int? {
        if isNontrivialDivisor(binaryArray: binaryArray, divisor: 2, base: base) {
            return 2
        }
        for divisor in stride(from: 3, to: end, by: 2) {
            if self.isNontrivialDivisor(binaryArray: binaryArray, divisor: divisor, base: base) {
                return divisor
            }
        }
        return nil
    }
        
    private func isNontrivialDivisor(binaryArray: Array<Int>, divisor: Int, base: Int) -> Bool {
        var remainders = Array<Int>(repeating: 0, count: binaryArray.count)
        for index in 0 ..< binaryArray.count {
            if index == 0 {
                remainders[index] = Int(pow(Double(base), Double(0))) % divisor
            } else {
                if remainders[index - 1] == 0 {
                    break
                } else {
                    remainders[index] = (remainders[index - 1] * base) % divisor
                }
            }
        }
        var remainder = 0
        for index in 0 ..< binaryArray.count {
            if binaryArray[binaryArray.count - 1 - index] == 1 {
                remainder += remainders[index]
            }
        }
        if remainder % divisor == 0 {
            return true
        } else {
            return false
        }
    }
    
}
