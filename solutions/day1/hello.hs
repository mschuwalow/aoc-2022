module Main (main) where
import Data.List (sortBy)

splitLines :: String -> [String]
splitLines text = go text [] []
  where
    go [] current acc = reverse (current : acc)
    go (x : xs) current acc
      | x == '\n' = go xs [] (reverse current : acc)
      | otherwise = go xs (x : current) acc

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
  print . sum . take 3 . sortBy (flip compare) $ sumPerElf
