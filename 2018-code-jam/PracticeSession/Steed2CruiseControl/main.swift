
struct Horse {
    
    let start: Double
    let speed: Double
    
    init(input: String) {
        let inputs = input.split(separator: " ").map { Double($0)! }
        self.start = inputs[0]
        self.speed = inputs[1]
    }
}

struct Steed {
    
    let distance: Double
    let horses: [Horse]
    
    init(input: (Double, [String])) {
        self.distance = input.0
        self.horses = input.1.map { Horse(input: $0) }
    }
    
    init() {
        let inputs = readLine()!.split(separator: " ")
        let distance = Double(inputs[0])!
        let horseCount = Int(inputs[1])!
        var horses: [String] = []
        for _ in 0 ..< horseCount {
            horses.append(readLine()!)
        }
        self.init(input: (distance, horses))
    }
    
    func output() -> String {
        let timeToArrive = self.timeToArrive()
        let maxSpeed = self.distance / timeToArrive
        return "\(maxSpeed)"
    }
    
    private func timeToArrive() -> Double {
        return self.horses.reduce(0) { (result, horse) -> Double in
            let time = (self.distance - horse.start) / horse.speed
            return max(result, time)
        }
    }
}

func start() {
    let count = Int(readLine()!)!
    for index in 1 ... count {
        let solution = Steed()
        let result = solution.output()
        print("Case #\(index): \(result)")
    }
}

//start()

struct Test {
    var input: (Double, [String])
    var expected: Double
}

let tests: Array<Test> = [
    Test(input: (2525, ["2400 5"]), expected: 101.000000),
    Test(input: (300, ["120 60", "60 90"]), expected: 100.000000),
    Test(input: (100, ["80 100", "70 10"]), expected: 33.333333),
]

tests.forEach({
    let solution = Steed(input: $0.input)
    let output = solution.output()
    if abs($0.expected - Double(output)!) < 0.000001 {
        print("✅ input: \($0.input), expected: \($0.expected)")
    } else {
        print("❗️ input: \($0.input), expected: \($0.expected), actually: \(output)")
    }
})
