module Utils where

{-@ average :: {xs:[Int] | len xs > 0} -> Int @-}
average :: [Int] -> Int
average xs = sum xs `div` length xs
