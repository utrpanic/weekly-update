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
    
    var startCoin: Int
    let maxCoin: Int
    var maxDivisors: Array<Int>
    let resultCount: Int
    
    init(input: String) {
        print(input)
        let inputs = input.components(separatedBy: " ").flatMap({ Int($0) })
        self.startCoin = Int(pow(Double(2), Double(inputs[0]) - 1)) + 1
        self.maxCoin = Int(pow(Double(2), Double(inputs[0])))
        self.maxDivisors = Array<Int>(repeating: 0, count: 11)
        for base in 2 ... 10 {
            self.maxDivisors[base] = Int(pow(Double(base), Double((inputs[0] + 1) / 2)))
        }
        self.resultCount = inputs[1]
    }
    
    func output() -> String {
        var results = Array<String>()
        for coin in stride(from: self.startCoin, to: self.maxCoin, by: 2) {
            let binaryText = String(coin, radix: 2)
            let binaryArray = binaryText.characters.flatMap({ Int(String($0)) })
            var result = binaryText
            for base in 2 ... 10 {
                if let nontrivialDivisor = self.getNontrivialDivisor(binaryArray: binaryArray, base: base) {
                    result.append(" \(nontrivialDivisor)")
                } else {
                    result = ""
                    break
                }
            }
            if !result.isEmpty {
                print("[jamcoin found] \(result)")
                results.append("\(result)")
            } else {
                print("[\(binaryText) is not jamcoin]")
            }
            if results.count == self.resultCount {
                break
            }
        }
        return results.joined(separator: "\n")
    }
    
    func getNontrivialDivisor(binaryArray: Array<Int>, base: Int) -> Int? {
        let date = Date()
        let from: Int
        let by: Int
        if base % 2 == 0 {
            from = 3
            by = 2
        } else {
            from = 2
            by = 1
        }
        let maxDivisor = self.maxDivisors[base]
        for divisor in stride(from: from, to: maxDivisor, by: by) {
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
                return divisor
            }
        }
        print("getNontrivialDivisor. \(Date().timeIntervalSince1970 - date.timeIntervalSince1970) sec.")
        return nil
    }
}
