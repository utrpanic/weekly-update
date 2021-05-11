# / 로 나누면 큰 숫자에 대해 정상적인 결과 안나옴. // 로 나눠야 함.

import math
import sys

class Solution:

    def start(self):
        count = int(sys.stdin.readline())
        for index in range(1, count + 1):
            _ = sys.stdin.readline().split(" ")
            cipherText = sys.stdin.readline()
            result = self.decodePangram(cipherText)
            print("Case #" + str(index) + ": " + result)

    def decodePangram(self, cipherText: str):
        numbers = list(map(lambda a: int(a), cipherText.split(" ")))
        (factor, position) = self.startingPoint(numbers)
        encoded = self.encoded(factor, position, numbers)
        return self.decode(encoded)

    def startingPoint(self, numbers: [int]):
        for index in range(0, len(numbers) - 1):
            if numbers[index] == numbers[index+1]:
                continue
            else:
                gcd = math.gcd(numbers[index], numbers[index+1])
                return (gcd, index)

    def encoded(self, factor: int, position: int, numbers: [int]):
        results = []

        eachFactor = factor
        for index in range(position, -1, -1):
            results.append(int(numbers[index]) // eachFactor)
            eachFactor = int(numbers[index]) // eachFactor
        results.reverse()

        results.append(factor)

        eachFactor = factor
        for index in range(position+1, len(numbers)):
            results.append(int(numbers[index]) // eachFactor)
            eachFactor = int(numbers[index]) // eachFactor

        return results

    def decode(self, primes: [int]):
        ordered = list(set(primes))
        ordered.sort()
        startValue = ord('A')
        dictionary = {}
        for index in range(0, len(ordered)):
            prime = ordered[index]
            dictionary[prime] = chr(startValue+index)
        return ''.join(list(map(lambda a: dictionary[a], primes)))

Solution().start()

testcases = [
    ("217 1891 4819 2291 2987 3811 1739 2491 4717 445 65 1079 8383 5353 901 187 649 1003 697 3239 7663 291 123 779 1007 3551 1943 2117 1679 989 3053",
     "CJQUIZKNOWBEVYOFDPFLUXALGORITHMS"),
    ("3292937 175597 18779 50429 375469 1651121 2102 3722 2376497 611683 489059 2328901 3150061 829981 421301 76409 38477 291931 730241 959821 1664197 3057407 4267589 4729181 5335543",
     "SUBDERMATOGLYPHICFJKNQVWXZ"),
    ("15 15 15 15 15 35 217 1891 4819 2291 2987 3811 1739 2491 4717 445 65 1079 8383 5353 901 187 649 1003 697 3239 7663 291 123 779 1007 3551 1943 2117 1679 989 3053",
     "ABABABCJQUIZKNOWBEVYOFDPFLUXALGORITHMS"),
    ("15 15 15 15 15 21 217 1891 4819 2291 2987 3811 1739 2491 4717 445 65 1079 8383 5353 901 187 649 1003 697 3239 7663 291 123 779 1007 3551 1943 2117 1679 989 3053",
     "BABABACJQUIZKNOWBEVYOFDPFLUXALGORITHMS"),
    ("9 9 9 9 21 217 1891 4819 2291 2987 3811 1739 2491 4717 445 65 1079 8383 5353 901 187 649 1003 697 3239 7663 291 123 779 1007 3551 1943 2117 1679 989 3053",
     "AAAAACJQUIZKNOWBEVYOFDPFLUXALGORITHMS"),
     
]
for testcase in testcases:
    input = testcase[0]
    expected = testcase[1]
    result = Solution().decodePangram(input)
    if result == expected:
        print("[SUCCESS]")
    else:
        print("[FAILURE] " + input)
        print("Expected: " + expected)
        print("Actually: " + result)
