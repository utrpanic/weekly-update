
struct Bound {
    
    var lower: Int
    var upper: Int
    
    init(lower: Int, upper: Int) {
        self.lower = lower
        self.upper = upper
    }
    
    init(input: String) {
        let inputs = input.split(separator: " ").map { Int($0)! }
        self.init(lower: inputs[0], upper: inputs[1])
    }
    
    func guess() -> Int {
        return (self.lower + self.upper) / 2
    }
}

func main() {
    let numberOfCase = Int(readLine()!)!
    for _ in 0 ..< numberOfCase {
        var bound = Bound(input: readLine()!)
        let maxGuesses = Int(readLine()!)!
        for _ in 0 ..< maxGuesses {
            let guess = bound.guess()
            print(guess)
            let result = readLine()!
            if result == "CORRECT" {
                break
            } else if result == "TOO_SMALL" {
                bound.lower = guess + 1
            } else if result == "TOO_BIG" {
                bound.upper = guess
            } else {
                return
            }
        }
    }
}

main()

// 테스트 방법은
// python ../../interactive_runner.py python3 local_testing_tool.py 0 -- swift NumberGuessing.swift
// 하지만 readline에서 읽어오질 못하는 듯.
