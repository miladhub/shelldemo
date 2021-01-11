module Main where

import           Banking

main :: IO ()
main = do
  result <- run $ do
    createAcct 42
    widthdraw 10
  putStrLn (show result)

instance Shell IO where
  readAcct  = readAcctIO
  writeAcct = writeAcctIO

readAcctIO :: IO Int
readAcctIO = readFile "acct.txt" >>= readIO

writeAcctIO :: Int -> IO ()
writeAcctIO acct = writeFile "acct.txt" (show acct)

