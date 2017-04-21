//
//  main.swift
//  Fractiles
//
//  Created by boxjeon on 2017. 4. 21..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

import Foundation

struct Test {
    var input: String
    var expected: String
}

let tests: Array<Test> = [
    Test(input: "2 3 2", expected: "2"),
    Test(input: "1 1 1", expected: "1"),
    Test(input: "2 1 1", expected: "IMPOSSIBLE"),
    Test(input: "2 1 2", expected: "1 2"),
    Test(input: "3 2 3", expected: "2 6"),
]

tests.forEach({
    print("input: \($0.input)")
    let output = Fractiles(input: $0.input).output()
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
        let result = Fractiles(input: input).output()
        outputs.append("Case #\(index): \(result)")
    }
    var outputUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    outputUrl.appendPathComponent(practiceName)
    outputUrl.appendPathExtension("out")
    try! outputs.joined(separator: "\n").write(to: outputUrl, atomically: true, encoding: .utf8)
}

generateOutput(practiceName: "D-small-practice")
generateOutput(practiceName: "D-large-practice")
