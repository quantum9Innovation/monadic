module Main where

import Constants
import Utils

import Data.Text (Text)

data Example = Example
  { name :: Text
  , age :: Int
  }
  deriving stock (Show, Eq)

{- |
 Main entry point.
-}
main :: IO ()
main = do
  putStrLn message
