// https://codingcompetitions.withgoogle.com/codejam/round/000000000043580a/00000000006d1155

struct Player {
    let questions: [Bool]
}

final class CheatingDetection {
    
    var players: [Player] = []
    var numberOfPlayers: Int { 100 }
    var numberOfQuestions: Int { 10000 }
    var probabilityPerPlayer: [Double] = []
    var probabilityPerQuestion: [Double] = []
    
    convenience init() {
        var inputs: [String] = []
        for _ in 0 ..< 100 {
            inputs.append(readLine()!)
        }
        self.init(inputs: inputs)
    }
    
    init(inputs: [String]) {
        inputs.forEach {
            let questions = $0.map({ question in String(question) == "1" })
            self.players.append(Player(questions: questions))
        }
    }
    
    func output() -> String {
        self.calculateProbabilityPerPlayer()
        self.calculateProbabilityPerQuestion()
        self.normalizeProbabilityPerPlayer()
        self.normalizeProbabilityPerQuestion()
        let differences = self.calculateDifferences()
        var maxIndex = 0
        var maxDifference: Double = 0
        for index in 0 ..< differences.count {
            if differences[index] > maxDifference {
                maxIndex = index
                maxDifference = differences[index]
            }
        }
        return "\(maxIndex + 1)"
    }
    
    private func calculateProbabilityPerPlayer() {
        for index in 0 ..< self.numberOfPlayers {
            var correctAnswerCount: Int = 0
            for answer in self.players[index].questions {
                correctAnswerCount += answer ? 1 : 0
            }
            let probability = Double(correctAnswerCount) / Double(self.numberOfQuestions)
            self.probabilityPerPlayer.append(probability)
        }
    }
    
    private func calculateProbabilityPerQuestion() {
        for index in 0 ..< self.numberOfQuestions {
            var correctAnswerCount: Int = 0
            for player in self.players {
                correctAnswerCount += player.questions[index] ? 1 : 0
            }
            let probability = Double(correctAnswerCount) / Double(self.numberOfPlayers)
            self.probabilityPerQuestion.append(probability)
        }
    }
    
    private func normalizeProbabilityPerPlayer() {
        // 필요하지 않을 수도.
    }
    
    private func normalizeProbabilityPerQuestion() {
        // 필요하지 않을 수도.
    }
    
    private func calculateDifferences() -> [Double] {
        var differences: [Double] = []
        for playerIndex in 0 ..< self.numberOfPlayers {
            var difference: Double = 0
            for questionIndex in 0 ..< self.numberOfQuestions {
                let skill = self.probabilityPerPlayer[playerIndex]
                let difficulty = self.probabilityPerQuestion[questionIndex]
                let probability = self.calculateProbability(skill: skill, difficulty: difficulty)
                if self.players[playerIndex].questions[questionIndex] {
                    difference += 1 - probability
                }
            }
            differences.append(difference)
        }
        return differences
    }
    
    // TODO: 이게 지금 0~1 값을 보장하지 않고 있다.
    // e를 하드코딩한 것이 문제인지, pow가 제대로 동작하지 않는 것인지.
    // pow가 Foundation 소속인 것도 문제.
    private func calculateProbability(skill: Double, difficulty: Double) -> Double {
        let numerator: Double = 1
        let x = skill - difficulty
        let denominator: Double = 1 - pow(2.718, -x)
        return numerator / denominator
    }
}

//let testCaseCount = Int(readLine()!)!
//_ = readLine()
//for index in 1 ... testCaseCount {
//    let output = CheatingDetection().output()
//    print("Case #\(index): \(output)")
//}

import Foundation

let path = Bundle.main.path(forResource: "cheating_detection_sample_ts1_input", ofType: "txt")!
var inputs = (try! String(contentsOfFile: path)).split(separator: "\n").map { String($0) }
_ = inputs.removeFirst()
_ = inputs.removeFirst()
let output = CheatingDetection(inputs: inputs).output()
print(output == "59" ? "[OK]" : output)
