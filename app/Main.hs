module Main where

import           Banking

main :: IO ()
main = show <$> run t >>= putStrLn

t :: Transaction IO
t = do
  createAcct 42
  widthdraw 10

instance Shell IO where
  readAcct  = readAcctIO
  writeAcct = writeAcctIO

readAcctIO :: IO Int
readAcctIO = readFile "acct.txt" >>= readIO

writeAcctIO :: Int -> IO ()
writeAcctIO acct = writeFile "acct.txt" (show acct)

