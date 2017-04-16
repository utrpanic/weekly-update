//
//  main.swift
//  CountingSheep
//
//  Created by gurren-l on 2017. 4. 15..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

let text0 = CountingSheep(firstNumber: 0).startToSleep()
if case .insomnia = text0 {
    print("[success] \(text0.text)")
} else {
    print("[FAILURE] expected: \(Finally.insomnia.text), actually: \(text0.text)")
}
let text1 = CountingSheep(firstNumber: 1).startToSleep()
if case .sleep(10) = text1 {
    print("[success] \(text1.text)")
} else {
    print("[FAILURE] expected: \(Finally.sleep(lastNumber: 10).text), actually: \(text1.text)")
}
let text2 = CountingSheep(firstNumber: 2).startToSleep()
if case .sleep(90) = text2 {
    print("[success] \(text2.text)")
} else {
    print("[FAILURE] expected: \(Finally.sleep(lastNumber: 90).text), actually: \(text2.text)")
}
let text3 = CountingSheep(firstNumber: 11).startToSleep()
if case .sleep(110) = text3 {
    print("[success] \(text3.text)")
} else {
    print("[FAILURE] expected: \(Finally.sleep(lastNumber: 110).text), actually: \(text3.text)")
}
let text4 = CountingSheep(firstNumber: 1692).startToSleep()
if case .sleep(5076) = text4 {
    print("[success] \(text4.text)")
} else {
    print("[FAILURE] expected: \(Finally.sleep(lastNumber: 5076).text), actually: \(text4.text)")
}

