import sys

def solve(lower, upper):
  m = (lower + upper) // 2
  print(m)
  sys.stdout.flush()
  result = input()
  if result == "CORRECT":
    return
  elif result == "TOO_SMALL":
    lower = m + 1
  elif result == "TOO_BIG":
    upper = m
  else:
    return
  solve(lower, upper)

T = int(input())
for _ in range(T):
  lower, upper = map(int, input().split())
  _ = int(input())
  solve(lower, upper)