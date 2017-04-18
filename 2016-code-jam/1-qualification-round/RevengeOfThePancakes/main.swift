//
//  main.swift
//  Revenge
//
//  Created by gurren-l on 2017. 4. 15..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

import Foundation

struct Test {
    var input: String
    var expected: String
}

let tests: Array<Test> = [
    Test(input: "-", expected: "1"),
    Test(input: "-+", expected: "1"),
    Test(input: "+-", expected: "2"),
    Test(input: "+++", expected: "0"),
    Test(input: "--+-", expected: "3"),
]

tests.forEach({
    let output = Revenge(input: $0.input).output()
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
        let result = Revenge(input: input).output()
        outputs.append("Case #\(index): \(result)")
    }
    var outputUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    outputUrl.appendPathComponent(practiceName)
    outputUrl.appendPathExtension("out")
    try! outputs.joined(separator: "\n").write(to: outputUrl, atomically: true, encoding: .utf8)
}

generateOutput(practiceName: "B-small-practice")

generateOutput(practiceName: "B-large-practice")
