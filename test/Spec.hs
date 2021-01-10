{-# LANGUAGE FlexibleInstances #-}

import           Banking
import           Control.Monad.State
import           Test.Hspec

instance Shell (State Int) where
  readAcct  = get
  writeAcct = put

exec :: Transaction (State Int) -> Either String Int
exec t = evalState (run t) 0

main :: IO ()
main = hspec $ do
  describe "banking" $ do
    it "allows creating an account" $ do
      exec (createAcct 42) `shouldBe` (Right 42)
