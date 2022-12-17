import Aoc.Utils (splitLines)
import Data.List (nub)
import Data.Char (ord, isLower)
import Data.Monoid (Sum(Sum, getSum))

splitRucksack :: String -> [String]
splitRucksack xs = [comp1, comp2]
  where
    (comp1, comp2) = splitAt middle xs
    middle = length xs `div` 2

chunksOf :: Int -> [a] -> [[a]]
chunksOf _ [] = []
chunksOf n xs = take n xs : chunksOf n (drop n xs)

commonItems :: Eq a => [[a]] -> [a]
commonItems [] = []
commonItems (x:xs) = nub . filter (\a -> all (elem a) xs) $ x

score :: Char -> Int
score c = if isLower c then ord c - 96 else ord c - 64 + 26

main = do
  inputData <- readFile "./data/day3/real.txt"
  let lines = filter (not . null) . splitLines $ inputData
  let result = getSum . foldMap (Sum . score) . (=<<) commonItems . chunksOf 3 $ lines
  print result
