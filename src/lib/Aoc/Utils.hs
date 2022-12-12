module Aoc.Utils (splitLines) where

splitLines :: String -> [String]
splitLines text = go text [] []
  where
    go [] current acc = reverse (current : acc)
    go (x : xs) current acc
      | x == '\n' = go xs [] (reverse current : acc)
      | otherwise = go xs (x : current) acc
