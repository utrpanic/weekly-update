
class DeceitfulWar {
    
    let numberOfBlock: Int
    let blocksOfKen: [Double]
    let blocksOfNaomi: [Double]
    
    convenience init() {
        let number = readLine()!
        let naomi = readLine()!
        let ken = readLine()!
        self.init(number: number, naomi: naomi, ken: ken)
    }
    
    init(number: String, naomi: String, ken: String) {
        self.numberOfBlock = Int(number)!
        self.blocksOfNaomi = naomi.split(separator: " ").map { Double($0)! }.sorted()
        self.blocksOfKen = ken.split(separator: " ").map { Double($0)! }.sorted()
    }
    
    func output() -> String {
        let deceitfulWarPoint = self.playDeceitfulWar()
        let warPoint = self.playWar()
        return "\(deceitfulWarPoint) \(warPoint)"
    }
    
    private func playDeceitfulWar() -> Int {
        var naomi = self.blocksOfNaomi
        var ken = self.blocksOfKen
        var naomiPoint = 0
        for _ in 0 ..< self.numberOfBlock {
            let toldNaomi = max(ken[ken.count - 1] + 0.000001, naomi[naomi.count - 1])
            let chosenIndexByKen = self.chosenIndexByKen(ken, chosenNaomi: toldNaomi)
            let chosenKen = ken.remove(at: chosenIndexByKen)
            let chosenIndexByNaomi = self.chosenIndexByNaomi(naomi, chosenKen: chosenKen)
            let chosenNaomi = naomi.remove(at: chosenIndexByNaomi)
            if chosenNaomi > chosenKen {
                naomiPoint += 1
            }
        }
        return naomiPoint
    }
    
    private func chosenIndexByNaomi(_ naomi: [Double], chosenKen: Double) -> Int {
        for index in 0 ..< naomi.count {
            if naomi[index] > chosenKen {
                return index
            }
        }
        return 0
    }
    
    private func chosenIndexByKen(_ ken: [Double], chosenNaomi: Double) -> Int {
        for index in 0 ..< ken.count {
            if ken[index] > chosenNaomi {
                return index
            }
        }
        return 0
    }
    
    private func playWar() -> Int {
        var naomi = self.blocksOfNaomi
        var ken = self.blocksOfKen
        var naomiPoint = 0
        for _ in 0 ..< self.numberOfBlock {
            let chosenNaomi = naomi.remove(at: 0)
            let chosenIndexByKen = self.chosenIndexByKen(ken, chosenNaomi: chosenNaomi)
            if chosenNaomi > ken.remove(at: chosenIndexByKen) {
                naomiPoint += 1
            }
        }
        return naomiPoint
    }
}

typealias Solution = DeceitfulWar

func start() {
    let count = Int(readLine()!)!
    for index in 1 ... count {
        let solution = Solution()
        print("Case #\(index): \(solution.output())")
    }
}

//start()

struct Test {
    var input: String
    var expected: String
}

let tests: Array<Test> = [
    Test(input: """
        1
        0.5
        0.6
        """, expected: "0 0"),
    Test(input: """
        2
        0.7 0.2
        0.8 0.3
        """, expected: "1 0"),
    Test(input: """
        3
        0.5 0.1 0.9
        0.6 0.4 0.3
        """, expected: "2 1"),
    Test(input: """
        9
        0.186 0.389 0.907 0.832 0.959 0.557 0.300 0.992 0.899
        0.916 0.728 0.271 0.520 0.700 0.521 0.215 0.341 0.458
        """, expected: "8 4"),
]

tests.forEach({
    let inputs = $0.input.split(separator: "\n").map { String($0) }
    let output = Solution(number: inputs[0], naomi: inputs[1], ken: inputs[2]).output()
    if $0.expected == output {
        print("✅ input: \($0.input), output: \(output)")
    } else {
        print("❗️ input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
})
