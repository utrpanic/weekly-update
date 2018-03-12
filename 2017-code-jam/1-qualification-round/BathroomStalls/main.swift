//
//  main.swift
//  BathroomStalls
//
//  Created by boxjeon on 2018. 3. 11..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

// https://code.google.com/codejam/contest/3264486/dashboard#s=p2

import Foundation

struct Test {
    var input: String
    var expected: String
}

let tests: Array<Test> = [
    Test(input: "4 2", expected: "1 0"),
    Test(input: "5 2", expected: "1 0"),
    Test(input: "6 2", expected: "1 1"),
    Test(input: "1000 1000", expected: "0 0"),
    Test(input: "1000 1", expected: "500 499"),
    Test(input: "999 499", expected: "1 0"),
    Test(input: "1000 489", expected: "1 0"),
]

tests.forEach({
    let output = BathroomStalls(input: $0.input).output()
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
        let result = BathroomStalls(input: input).output()
        outputs.append("Case #\(index): \(result)")
    }
    var outputUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    outputUrl.appendPathComponent(practiceName)
    outputUrl.appendPathExtension("out")
    try! outputs.joined(separator: "\n").write(to: outputUrl, atomically: true, encoding: .utf8)
}

generateOutput(practiceName: "C-small-practice-1")
generateOutput(practiceName: "C-small-practice-2")
generateOutput(practiceName: "C-large-practice")

