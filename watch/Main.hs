module Main(main)
where

import System.INotify
import System.Process
import Control.Concurrent(threadDelay)
import Control.Monad(forever)

recompile :: IO ()
recompile = callProcess "stack" ["exec", "site", "--", "build"]

main :: IO ()
main = withINotify $ \inotify -> do
  addWatch inotify [Modify] "slides.md" $ const recompile
  addWatch inotify [Create,Modify] "slides" $ const recompile
  -- sleep forever, notifications happen in separate thread
  forever $ threadDelay 1000000
