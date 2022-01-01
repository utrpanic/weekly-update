
class AppendSort {
    
    var numberOfModification = 0
    var inputs: [[String]]

    init(_ array: [String]) {
        self.inputs = array.map { string in
            return string.map { String($0) }
        }
    }
    
    convenience init(_ input: String) {
        self.init(input.split(separator: " ").map { String($0) })
    }
    
    func result() -> Int {
        for index in 1 ..< self.inputs.count {
            self.compareThenAppendIfNeeded(index-1, index)
        }
        return self.numberOfModification
    }
    
    private func compareThenAppendIfNeeded(_ previousIndex: Int, _ currentIndex: Int) {
        let previous = self.inputs[previousIndex]
        let optimal = self.minimumLargerNumber(of: previous)
        var current = self.inputs[currentIndex]
        if self.smaller(previous, than: current) {
            return
        } else if previous == current {
            current.append("0")
            self.numberOfModification += 1
            self.inputs[currentIndex] = current
        } else {
            var sameHead = true
            var index = 0
            while self.smaller(current, than: optimal) {
                if index < current.count {
                    if sameHead {
                        sameHead = optimal[index] == current[index]
                    }
                } else {
                    if sameHead {
                        current.append(optimal[index])
                    } else {
                        current.append("0")
                    }
                    self.numberOfModification += 1
                }
                index += 1
            }
            self.inputs[currentIndex] = current
        }
    }
    
    private func minimumLargerNumber(of string: [String]) -> [String] {
        var number: [String] = []
        var plusOne = true
        string.reversed().forEach { character in
            if plusOne {
                let newNumber = Int(character)! + 1
                if newNumber == 10 {
                    number.append("0")
                } else {
                    number.append(String(newNumber))
                    plusOne = false
                }
            } else {
                number.append(character)
            }
        }
        if plusOne {
            number.append("1")
        }
        return number.reversed()
    }
    
    private func smaller(_ a: [String], than b: [String]) -> Bool {
        if a.count < b.count {
            return true
        } else if a.count > b.count {
            return false
        } else {
            for index in 0 ..< a.count {
                if a[index] < b[index] {
                    return true
                } else if a[index] > b[index] {
                    return false
                }
            }
        }
        return false
    }
}

let numberOfTests = Int(readLine()!)!
for index in 1 ... numberOfTests {
    let _ = readLine()
    let input = readLine()!
    let solution = AppendSort(input)
    print("Case #\(index): \(solution.result())")
}

print(AppendSort(["100", "7", "10"]).result() == 4)
print(AppendSort(["10", "10"]).result() == 1)
print(AppendSort(["4", "19", "1"]).result() == 2)
print(AppendSort(["1", "2", "3"]).result() == 0)
print(AppendSort(["999", "99", "9"]).result() == 5)
