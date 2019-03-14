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
  -- Include example files, excluding build artifacts
  match ("examples/**" .&&. complement "examples/*/build/**") $ compile getResourceBody
  match "css/**" $ do
    route idRoute
    compile copyFileCompiler
  match "slides/*.md" $ do
    compile templateBodyCompiler
  match "slides.md" $ do
   route . customRoute $ const "index.html"
   compile $
     getResourceString
     >>= applyAsTemplate (mconcat [snippetField, snippetRangeField])
     >>= renderPandoc
     >>= loadAndApplyTemplate "templates/index.html" slidesContext

slidesContext :: Context String
slidesContext = field "slides" $ \item -> return (itemBody item)

snippetRangeField :: Context String
snippetRangeField = functionField "snippetRange" f where
  f [contentsPath, sFrom, sTo] _ = selectRange <$> loadBody (fromFilePath contentsPath) where
      selectRange = unlines . take (to - from + 1) . drop (from-1) . lines
      from = read sFrom
      to = read sTo
  f xs _ = fail $ "snippetRange() takes 3 arguments, but " ++ (show $ length xs) ++ " provided"
