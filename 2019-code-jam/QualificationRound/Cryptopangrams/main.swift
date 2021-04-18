class Solution {
    
    func start() {
        let count = Int(readLine() ?? "")!
        for index in 1 ... count {
            _ = (readLine() ?? "").split(separator: " ")
            let cipherText = readLine()!
            let result = self.decodePangram(cipherText)
            print("Case #\(index): \(result)")
        }
    }
    
    func decodePangram(_ cipherText: String) -> String {
        let numbers = cipherText.split(separator: " ").map { Double($0)! }
        let (factor, position) = self.startingPoint(numbers)
        let encoded = self.encoded(with: factor, at: position, numbers: numbers)
        return self.decode(from: encoded)
    }
    
    func startingPoint(_ numbers: [Double]) -> (Double, Int) {
        for index in 0 ..< numbers.count - 1 {
            let gcd = numbers[index].greatestCommonDivisor(with: numbers[index+1])
            if gcd == numbers[index] {
                continue
            } else {
                return (gcd, index)
            }
        }
        fatalError()
    }
    
    func encoded(with factor: Double, at position: Int, numbers: [Double]) -> [Double] {
        var results: [Double] = []
        
        var eachFactor = factor
        for index in (0 ... position).reversed() {
            results.append(numbers[index] / eachFactor)
            eachFactor = numbers[index] / eachFactor
        }
        results.reverse()
        
        results.append(factor)
        
        eachFactor = factor
        for index in (position + 1) ..< numbers.count {
            results.append(numbers[index] / eachFactor)
            eachFactor = numbers[index] / eachFactor
        }
        return results
    }
    
    func decode(from primes: [Double]) -> String {
        let ordered = Array(Set(primes)).sorted()
        let startingValue = Int(("A" as UnicodeScalar).value) // 65
        var dictionary: [Double: String] = [:]
        for (index, prime) in ordered.enumerated() {
            dictionary[prime] = String(UnicodeScalar(startingValue + index)!)
        }
        return primes.map({ dictionary[$0]! }).joined()
    }
}

extension Double {
    
    func greatestCommonDivisor(with other: Double) -> Double {
        var newA = self
        var newB = other
        while newA != newB {
            if newA < newB {
                newB -= newA
            } else {
                newA -= newB
            }
        }
        return newA
    }
}

Solution().start()

let testcases = [
    ("217 1891 4819 2291 2987 3811 1739 2491 4717 445 65 1079 8383 5353 901 187 649 1003 697 3239 7663 291 123 779 1007 3551 1943 2117 1679 989 3053",
     "CJQUIZKNOWBEVYOFDPFLUXALGORITHMS"),
    ("3292937 175597 18779 50429 375469 1651121 2102 3722 2376497 611683 489059 2328901 3150061 829981 421301 76409 38477 291931 730241 959821 1664197 3057407 4267589 4729181 5335543",
     "SUBDERMATOGLYPHICFJKNQVWXZ")
]
testcases.forEach { (input, expected) in
    let result = Solution().decodePangram(input)
    if result == expected {
        print("[SUCCESS]")
    } else {
        print("[FAILURE] \(input)")
        print("Expected: \(expected)")
        print("Actually: \(result)")
    }
}
