class Solution {
    
    func start() {
        let count = Int(readLine() ?? "")!
        for index in 1 ... count {
            _ = Int(readLine() ?? "")! // maze size
            let rival = readLine()!
            let result = self.findMyOwnWay(rival)
            print("Case #\(index): \(result)")
        }
    }
    
    func findMyOwnWay(_ rival: String) -> String {
        var result = ""
        rival.forEach { (char) in
            if char == "S" {
                result.append("E")
            } else if char == "E" {
                result.append("S")
            }
        }
        return result
    }
}

Solution().start()
