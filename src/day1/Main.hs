module Main (main) where

import Data.List (sortBy)
import Aoc.Utils (splitLines)

groupByEmptyLines :: [String] -> [[String]]
groupByEmptyLines [] = []
groupByEmptyLines lines = currentGroup : remainder
  where
    currentGroup = takeWhile (not . null) lines
    remainder = groupByEmptyLines . drop 1 . dropWhile (not . null) $ lines

sumGroups :: [[String]] -> [Int]
sumGroups = fmap (sum . fmap read)

main = do
  input <- readFile "./data/day1/real.txt"
  let sumPerElf = sumGroups . groupByEmptyLines . splitLines $ input
  let result = sum . take 3 . sortBy (flip compare) $ sumPerElf
  print result
