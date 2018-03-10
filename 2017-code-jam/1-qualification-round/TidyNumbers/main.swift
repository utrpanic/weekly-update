//
//  main.swift
//  TidyNumbers
//
//  Created by boxjeon on 2018. 3. 10..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

// https://code.google.com/codejam/contest/3264486/dashboard#s=p1

import Foundation

struct Test {
    var input: String
    var expected: String
}

let tests: Array<Test> = [
    Test(input: "132", expected: "129"),
    Test(input: "1000", expected: "999"),
    Test(input: "7", expected: "7"),
    Test(input: "111111111111111110", expected: "99999999999999999"),
]

tests.forEach({
    let output = TidyNumbers(input: $0.input).output()
    if $0.expected == output {
        print("[success] input: \($0.input), output: \(output)")
    } else {
        print("[FAILURE] input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
})

func generateOutput(practiceName: String) {
    let path = Bundle.main.path(forResource: practiceName, ofType: "in")!
    let inputs = (try! String(contentsOfFile: path)).components(separatedBy: "\n").filter({ !$0.isEmpty })
    var outputs = Array<String>()
    for index in stride(from: 1, to: inputs.count, by: 1) {
        let input = inputs[index]
        let result = TidyNumbers(input: input).output()
        outputs.append("Case #\(index): \(result)")
    }
    var outputUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    outputUrl.appendPathComponent(practiceName)
    outputUrl.appendPathExtension("out")
    try! outputs.joined(separator: "\n").write(to: outputUrl, atomically: true, encoding: .utf8)
}

generateOutput(practiceName: "B-small-practice")

generateOutput(practiceName: "B-large-practice")

