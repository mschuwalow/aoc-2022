module Main where

import Aoc.Utils (splitLines)
import Data.Monoid (Sum(Sum, getSum))

scoreGame :: String -> Int
scoreGame game =
  case game of
    "A X" -> 0 + 3
    "A Y" -> 3 + 1
    "A Z" -> 6 + 2

    "B X" -> 0 + 1
    "B Y" -> 3 + 2
    "B Z" -> 6 + 3

    "C X" -> 0 + 2
    "C Y" -> 3 + 3
    "C Z" -> 6 + 1

    _     -> 0


main = do
  input <- readFile "./data/day2/real.txt"
  let result = getSum . foldMap (Sum . scoreGame) . splitLines $ input
  print result
