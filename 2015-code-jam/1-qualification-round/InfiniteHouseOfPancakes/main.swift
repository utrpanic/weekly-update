//
//  main.swift
//  InfiniteHouseOfPancakes
//
//  Created by gurren-l on 2017. 4. 16..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

import Foundation

struct Test {
    var input: String
    var expected: String
}

let tests: Array<Test> = [
    Test(input: "1 3", expected: "3"),
    Test(input: "4 1 2 1 2", expected: "2"),
    Test(input: "1 4", expected: "3"),
]

tests.forEach({
    let output = HouseOfPancakes(input: $0.input).output()
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
    for index in stride(from: 1, to: inputs.count, by: 2) {
        let input = inputs[index].appending(" ").appending(inputs[index + 1])
        let result = HouseOfPancakes(input: input).output()
        outputs.append("Case #\(index / 2 + 1): \(result)")
    }
    var outputUrl = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    outputUrl.appendPathComponent(practiceName)
    outputUrl.appendPathExtension("out")
    try! outputs.joined(separator: "\n").write(to: outputUrl, atomically: true, encoding: .utf8)
}

generateOutput(practiceName: "B-small-practice")

generateOutput(practiceName: "B-large-practice")
