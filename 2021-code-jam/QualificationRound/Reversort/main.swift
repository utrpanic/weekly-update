
let testCaseCount = Int(readLine()!)!
for index in 1 ... testCaseCount {
    let output = Reversort().output()
    print("Case #\(index): \(output)")
}

//let testCases: [(String, String)] = [
//    ("4 2 1 3", "6"),
//    ("1 2", "1"),
//    ("7 6 5 4 3 2 1", "12")
//
//]
//
//testCases.forEach { (input, expected) in
//    let result = Reversort(input: input).output()
//    print(result == expected ? "OK" : result)
//}
