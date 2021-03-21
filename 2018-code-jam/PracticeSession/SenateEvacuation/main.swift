
class SenateEvacuation {
    
    var numberOfParties: Int
    var parties: [Int]
    var evacuations: [String]
    var remainder: Int
    
    init() {
        self.numberOfParties = Int(readLine()!)!
        self.parties = readLine()!.split(separator: " ").map { Int(String($0))! }
        self.evacuations = []
        self.remainder = self.parties.reduce(0, +)
    }
    
    init(inputs: [String]) {
        self.numberOfParties = Int(inputs[0])!
        self.parties = inputs[1].split(separator: " ").map { Int($0)! }
        self.evacuations = []
        self.remainder = self.parties.reduce(0, +)
    }
    
    func evacuateOne() -> Int {
        var maxIndex: Int = 0
        var maxCount: Int = 0
        for (index, count) in self.parties.enumerated() {
            if maxCount < count {
                maxIndex = index
                maxCount = count
            }
        }
        self.parties[maxIndex] -= 1
        self.remainder -= 1
        return maxIndex
    }
    
    func resolve() -> String {
        while self.remainder > 0 {
            if self.remainder == 3 {
                let index = self.evacuateOne()
                let party = self.partyCharacter(of: index)
                self.evacuations.append(party)
            } else {
                let firstIndex = self.evacuateOne()
                let firstParty = self.partyCharacter(of: firstIndex)
                let secondIndex = self.evacuateOne()
                let secondParty = self.partyCharacter(of: secondIndex)
                self.evacuations.append(firstParty + secondParty)
            }
//            self.validate()
        }
        return self.evacuations.joined(separator: " ")
    }
    
    private func partyCharacter(of index: Int) -> String {
        let asciiValue = Int(Character("A").asciiValue!) + index
        return String(UnicodeScalar(asciiValue)!)
    }
    
    func validate() {
        self.parties.forEach {
            if self.remainder / 2 < $0 {
                print("WRONG ANSWER")
            }
        }
        print("VALID")
    }
}

//SenateEvacuation(inputs: [
//    "2",
//    "2 2"
//]).resolve()
//SenateEvacuation(inputs: [
//    "3",
//    "3 2 2"
//]).resolve()
//SenateEvacuation(inputs: [
//    "3",
//    "1 1 2"
//]).resolve()
//SenateEvacuation(inputs: [
//    "3",
//    "2 3 1"
//]).resolve()

class Solution {
    
    func solve() {
        let testCount = Int(readLine()!)!
        for index in 1 ... testCount {
            print("Case #\(index): \(SenateEvacuation().resolve())")
        }
    }
}

Solution().solve()
