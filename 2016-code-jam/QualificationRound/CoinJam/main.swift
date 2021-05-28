
class CoinJam {
    
    var jamCoinlength: Int
    var jamCoinCount: Int
    
    init(input: String) {
        let inputs = input.split(separator: " ")
        self.jamCoinlength = Int(inputs[0])!
        self.jamCoinCount = Int(inputs[1])!
    }
    
    convenience init() {
        let input = readLine()!
        self.init(input: input)
    }
    
    func output() -> String {
        var result = ""
        loop: for i in 0 ..< self.jamCoinlength - 10 {
            for j in 0 ..< self.jamCoinlength - 10 - i {
                for k in 0 ..< self.jamCoinlength - 10 - i - j {
                    let l = self.jamCoinlength - 10 - i - j - k
                    let jamCoin = ""
                        .appended("11")
                        .appendedZero(i)
                        .appended("11")
                        .appendedZero(j)
                        .appended("11")
                        .appendedZero(k)
                        .appended("11")
                        .appendedZero(l)
                        .appended("11")
                    result.append("\(jamCoin) 3 4 5 6 7 8 9 10 11\n")
                    self.jamCoinCount -= 1
                    if self.jamCoinCount == 0 {
                        break loop
                    }
                }
            }
        }
        return result
    }
}

extension String {
    
    func appendedZero(_ count: Int) -> String {
        var result = self
        for _ in 0 ..< count {
            result.append("0")
        }
        return result
    }
    
    func appended(_ string: String) -> String {
        var result = self
        result.append(string)
        return result
    }
}

typealias Solution = CoinJam

func start() {
    let count = Int(readLine()!)!
    for index in 1 ... count {
        let solution = Solution()
        print("Case #\(index):\n\(solution.output())")
    }
}

start()
