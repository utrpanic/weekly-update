//
//  main.swift
//  FashionShow
//
//  Created by boxjeon on 2018. 3. 13..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

// https://code.google.com/codejam/contest/3264486/dashboard#s=p3

import Foundation

struct Test {
    var input: (Int, [String])
    var expected: (point: Int, models: [String])
}

func == (lhs: (Int, [String]), rhs: (Int, [String])) -> Bool {
    return lhs.0 == rhs.0
}

let tests: Array<Test> = [
    Test(input: (2, []), expected: (point: 4, models: ["o 2 2", "+ 2 1", "x 1 1"])),
    Test(input: (1, ["o 1 1"]), expected: (point: 2, models: [])),
    Test(input: (3, ["+ 2 3", "+ 2 1", "x 3 1", "+ 2 2"]), expected: (point: 6, models: ["o 2 3", "x 1 2"])),
]

tests.forEach({
    let output = FashionShow(input: $0.input).output()
    if $0.expected == output {
        print("[success] input: \($0.input),\nexpected: \($0.expected),\nactually: \(output)\n")
    } else {
        print("[FAILURE] input: \($0.input),\nexpected: \($0.expected),\nactually: \(output)\n")
    }
})

func generateOutput(practiceName: String) {
    let path = Bundle.main.path(forResource: practiceName, ofType: "in")!
    let inputs = (try! String(contentsOfFile: path)).components(separatedBy: "\n").filter({ !$0.isEmpty })
    var outputs = Array<String>()
    var testCaseIndex = 1
    var index = 1
    while index < inputs.count {
        let input = inputs[index].split(separator: " ")
        let n = Int(input[0])!
        let gridCount = Int(input[1])!
        var grids = [String]()
        for gridIndex in 0 ..< gridCount {
            grids.append(inputs[index + gridIndex + 1])
        }
        let result = FashionShow(input: (n, grids)).output()
        outputs.append("Case #\(testCaseIndex): \(result.point) \(result.models.count)")
        for modelIndex in 0 ..< result.models.count {
            outputs.append("\(result.models[modelIndex])")
        }
        index += 1 + gridCount
        testCaseIndex += 1
    }
    var outputUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    outputUrl.appendPathComponent(practiceName)
    outputUrl.appendPathExtension("out")
    try! outputs.joined(separator: "\n").write(to: outputUrl, atomically: true, encoding: .utf8)
}

//generateOutput(practiceName: "D-small-practice")
//generateOutput(practiceName: "D-large-practice")

