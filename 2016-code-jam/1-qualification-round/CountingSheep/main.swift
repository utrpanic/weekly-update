//
//  main.swift
//  CountingSheep
//
//  Created by boxjeon on 2017. 4. 15..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

import Foundation

struct Test {
    var input: String
    var expected: String
}

let tests: Array<Test> = [
    Test(input: "0", expected: CountingSheep.insomnia),
    Test(input: "1", expected: "10"),
    Test(input: "2", expected: "90"),
    Test(input: "11", expected: "110"),
    Test(input: "1692", expected: "5076"),
]

tests.forEach({
    let output = CountingSheep(input: $0.input).output()
    if $0.expected == output {
        print("[success] \(output)")
    } else {
        print("[FAILURE] expected: \($0.expected), actually: \(output)")
    }
})

func generateOutput(practiceName: String) {
    let path = Bundle.main.path(forResource: practiceName, ofType: "in")!
    let inputs = (try! String(contentsOfFile: path)).components(separatedBy: "\n").filter({ !$0.isEmpty })
    var outputs = Array<String>()
    for index in stride(from: 1, to: inputs.count, by: 1) {
        let input = inputs[index]
        let result = CountingSheep(input: input).output()
        outputs.append("Case #\(index): \(result)")
    }
    var outputUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    outputUrl.appendPathComponent(practiceName)
    outputUrl.appendPathExtension("out")
    try! outputs.joined(separator: "\n").write(to: outputUrl, atomically: true, encoding: .utf8)
}

generateOutput(practiceName: "A-small-practice")

generateOutput(practiceName: "A-large-practice")
