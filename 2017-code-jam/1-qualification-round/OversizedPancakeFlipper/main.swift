//
//  main.swift
//  OversizedPancakeFlipper
//
//  Created by boxjeon on 2017. 12. 6..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

// https://code.google.com/codejam/contest/3264486/dashboard#s=p0

import Foundation

struct Test {
    var input: String
    var expected: String
}

let tests: Array<Test> = [
    Test(input: "---+-++- 3", expected: "3"),
    Test(input: "+++++ 4", expected: "0"),
    Test(input: "-+-+- 4", expected: "IMPOSSIBLE"),
]

tests.forEach({
    let output = OversizedPancakeFlipper(input: $0.input).output()
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
        let result = OversizedPancakeFlipper(input: input).output()
        outputs.append("Case #\(index): \(result)")
    }
    var outputUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    outputUrl.appendPathComponent(practiceName)
    outputUrl.appendPathExtension("out")
    try! outputs.joined(separator: "\n").write(to: outputUrl, atomically: true, encoding: .utf8)
}

generateOutput(practiceName: "A-small-practice")

generateOutput(practiceName: "A-large-practice")
