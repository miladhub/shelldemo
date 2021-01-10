module Banking (Transaction, Shell(..), run, createAcct, deposit, widthdraw) where

import           Control.Monad.Except

class Monad m => Shell m where
  readAcct  :: m Int
  writeAcct :: Int -> m ()

type Transaction m = ExceptT String m Int

run :: Shell m => Transaction m -> m (Either String Int)
run = runExceptT

createAcct :: Shell m => Int -> Transaction m
createAcct amnt = do
  if (amnt > 0) then do
    lift $ writeAcct amnt
    return amnt
  else
    throwError "Amount must be positive"

deposit :: Shell m => Int -> Transaction m
deposit amnt = do
  acct <- lift readAcct
  lift $ writeAcct (acct + amnt)
  return (acct + amnt)

widthdraw :: Shell m => Int -> Transaction m
widthdraw amnt = do
  acct <- lift readAcct
  if (amnt <= acct) then do
    lift $ writeAcct (acct - amnt)
    return (acct - amnt)
  else
    throwError "Funds not sufficient"

