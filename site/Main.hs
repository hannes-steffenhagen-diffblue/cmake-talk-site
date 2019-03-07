{-# LANGUAGE OverloadedStrings #-}
module Main where

import System.FilePath.Posix(splitPath, joinPath)
import Hakyll
import Data.String(fromString)

copyRevealResources :: Rules ()
copyRevealResources = do
  revealResource "css"
  revealResource "js"
  revealResource "lib"
  revealResource "plugin"
  where
    revealResource x = match (revealPath x) $ do
      route . customRoute $ joinPath . tail . splitPath . toFilePath
      compile copyFileCompiler
    revealPath = fromString . (++"/**") . ("reveal.js-3.7.0/"++)

main :: IO ()
main = hakyll $ do
  copyRevealResources
  match "templates/*" $ do
    compile templateBodyCompiler
  match "examples/**" $ compile getResourceBody
  match "css/**" $ do
    route idRoute
    compile copyFileCompiler
  match "slides.md" $ do
   route . customRoute $ const "index.html"
   compile $
     getResourceString
     >>= applyAsTemplate snippetField
     >>= renderPandoc
     >>= loadAndApplyTemplate "templates/index.html" slidesContext

slidesContext :: Context String
slidesContext = mconcat
  [field "slides" $ \item -> return (itemBody item)]
