module Main where

import Constants
import Utils
import Style

import Data.Monoid (mappend)
import System.FilePath (takeFileName)
import Hakyll

main :: IO ()
main = generateSite

generateSite :: IO ()
generateSite = hakyll $ do
  match "images/*" $ do
    sameRoute
    compile copyFileCompiler
    
  match "root/favicon.*" $ do
    reroute takeFileName
    compile copyFileCompiler
    
  match "fonts/degheest/fonts/otf/*" $ do
    reroute toFontDir
    compile copyFileCompiler
    
  match "fonts/lilex/otf/*" $ do
    reroute toFontDirSimple
    compile copyFileCompiler
    
  match "fonts/libertinus/*" $ do
    sameRoute
    compile copyFileCompiler
    
  create ["css/style.css"] $ do
    sameRoute
    compile $ makeItem css
    
  match "css/*.css" $ do
    sameRoute
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
    sameRoute
    compile $ do
      posts <- compilePosts
      let archiveCtx =
            listField postsDir postContext (return posts)
              `mappend` constField "title" "Archives"
              `mappend` defaultContext

      hydrate archiveCtx $ makeItem "" >>= loadAndApplyTemplate archiveTemplate archiveCtx

  match "root/index.html" $ do
    reroute takeFileName
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
