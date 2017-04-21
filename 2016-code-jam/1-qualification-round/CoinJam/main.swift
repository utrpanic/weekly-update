//
//  main.swift
//  CoinJam
//
//  Created by boxjeon on 2017. 4. 20..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

import Foundation

func verify(output: String) {
    output.components(separatedBy: "\n").filter({ !$0.isEmpty }).forEach { (jamcoinRecord) in
        var records = jamcoinRecord.components(separatedBy: " ").filter({ !$0.isEmpty })
        let jamcoin = records.remove(at: 0)
        let nontrivalDivisors: Array<Int> = records.flatMap({ Int($0) })
        for base in 2 ..< 10 {
            let number = Int(jamcoin, radix: base)!
            let nontrivialDivisor: Int = nontrivalDivisors[base - 2]
            let divider = number / nontrivialDivisor
            let remainder = number % nontrivialDivisor
            if remainder > 0 || (remainder == 0 && divider == 1) || (remainder == 0 && divider == number) {
                print("[FAILURE]: \(jamcoinRecord)")
                return
            }
        }
        print("[success]: \(jamcoinRecord)")
    }
}

verify(output: "100011 5 13 147 31 43 1121 73 77 629\n111111 21 26 105 1302 217 1032 513 13286 10101\n111001 3 88 5 1938 7 208 3 20 11")

func generateOutput(practiceName: String) {
    let path = Bundle.main.path(forResource: practiceName, ofType: "in")!
    let inputs = (try! String(contentsOfFile: path)).components(separatedBy: "\n").filter({ !$0.isEmpty })
    var outputs = Array<String>()
    for index in stride(from: 1, to: inputs.count, by: 1) {
        let input = inputs[index]
        let result = CoinJam(input: input).output()
        outputs.append("Case #\(index):\n\(result)")
        verify(output: result)
    }
    var outputUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    outputUrl.appendPathComponent(practiceName)
    outputUrl.appendPathExtension("out")
    try! outputs.joined(separator: "\n").write(to: outputUrl, atomically: true, encoding: .utf8)
}

generateOutput(practiceName: "C-small-practice")
//generateOutput(practiceName: "C-large-practice")
