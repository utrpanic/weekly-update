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
    let resultCount: Int
    
    init(input: String) {
        print(input)
        let inputs = input.components(separatedBy: " ").flatMap({ Int($0) })
        self.startCoin = Int(pow(Double(2), Double(inputs[0]) - 1)) + 1
        self.maxCoin = Int(pow(Double(2), Double(inputs[0])))
        self.resultCount = inputs[1]
    }
    
    func output() -> String {
        var results = Array<String>()
        for coin in stride(from: self.startCoin, to: self.maxCoin, by: 2) {
            let binaryText = String(coin, radix: 2)
            var result = binaryText
            for base in 2 ... 10 {
                let number = Int(binaryText, radix: base)!
                print("Number in base \(base): \(number)")
                if let nontrivialDivisor = self.getNontrivialDivisor(of: number) {
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
    
    func getNontrivialDivisor(of number: Int) -> Int? {
        if number % 2 == 0 {
            return 2
        } else {
            for divisor in stride(from: 3, to: Int(sqrt(Double(number))), by: 2) {
                if number % divisor == 0 {
                    return divisor
                }
            }
            return nil
        }
    }
    
}
