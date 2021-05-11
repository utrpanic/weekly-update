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
        var result = ""
        let numbers = cipherText.split(separator: " ").map { Int($0)! }
        let factors = self.extractFactors(numbers.first!)
        let primes = self.decodeToPrimes(firstFactors: factors, numbers: numbers)
        result = self.decode(from: primes)
        return result
    }
    
    func extractFactors(_ number: Int) -> (Int, Int) {
        var factor = 2
        let maxFactor = Double(number).squareRoot()
        while Double(factor) <= maxFactor {
            if number % factor == 0 {
                return (factor, number / factor)
            } else {
                if factor == 2 {
                    factor += 1
                } else {
                    factor += 2
                }
            }
        }
        fatalError()
    }
    
    func decodeToPrimes(firstFactors: (Int, Int), numbers: [Int]) -> [Int] {
        var result: [Int] = []
        for (index, number) in numbers.enumerated() {
            if index == 0 {
                result.append(firstFactors.0)
            }
            if (number % result.last! == 0) {
                result.append(number / result.last!)
            } else {
                result = []
                break
            }
        }
        if !result.isEmpty {
            return result
        } else {
            for (index, number) in numbers.enumerated() {
                if index == 0 {
                    result.append(firstFactors.1)
                }
                if (number % result.last! == 0) {
                    result.append(number / result.last!)
                } else {
                    result = []
                    break
                }
            }
        }
        return result
    }
    
    func decode(from primes: [Int]) -> String {
        let ordered = Array(Set(primes)).sorted()
        let startingValue = Int(("A" as UnicodeScalar).value) // 65
        var dictionary: [Int: String] = [:]
        for (index, prime) in ordered.enumerated() {
            dictionary[prime] = String(UnicodeScalar(startingValue + index)!)
        }
        return primes.map({ dictionary[$0]! }).joined()
    }
}

Solution().start()
//print("actually: \(Solution().decodePangram("217 1891 4819 2291 2987 3811 1739 2491 4717 445 65 1079 8383 5353 901 187 649 1003 697 3239 7663 291 123 779 1007 3551 1943 2117 1679 989 3053"))")
//print("expected: CJQUIZKNOWBEVYOFDPFLUXALGORITHMS")
//print("actually: \(Solution().decodePangram("3292937 175597 18779 50429 375469 1651121 2102 3722 2376497 611683 489059 2328901 3150061 829981 421301 76409 38477 291931 730241 959821 1664197 3057407 4267589 4729181 5335543"))")
//print("expected: SUBDERMATOGLYPHICFJKNQVWXZ")
