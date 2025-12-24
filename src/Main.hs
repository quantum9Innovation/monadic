module Main where

import Constants
import Utils

import Data.Monoid (mappend)
import Hakyll

main :: IO ()
main = hakyll $ do
  match "images/*" $ do
    sameRoot
    compile copyFileCompiler

  match "css/*" $ do
    sameRoot
    compile compressCssCompiler

  match (fromList topLevel) $ do
    route $ setExtension "html"
    make pandocCompiler

  match "posts/*" $ do
    route $ setExtension "html"
    build postContext $
      pandocCompiler
        >>= loadAndApplyTemplate postTemplate postContext
        >>= saveSnapshot snapshotDir

  create ["archive.html"] $ do
    sameRoot
    compile $ do
      posts <- compilePosts
      let archiveCtx =
            listField postsDir postContext (return posts)
              `mappend` constField "title" "Archives"
              `mappend` defaultContext

      hydrate archiveCtx $ makeItem "" >>= loadAndApplyTemplate archiveTemplate archiveCtx

  match "index.html" $ do
    sameRoot
    compile $ do
      posts <- compilePosts
      let indexCtx =
            listField "posts" postContext (return posts)
              `mappend` defaultContext

      hydrate indexCtx $ getResourceBody >>= applyAsTemplate indexCtx

  match "templates/*" $ compile templateBodyCompiler

  create ["atom.xml"] $ makeFeed renderAtom
  create ["feed.xml"] $ makeFeed renderRss
  create ["feed.json"] $ makeFeed renderJson
