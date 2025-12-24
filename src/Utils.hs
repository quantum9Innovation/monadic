module Utils where

import Constants
import Types

import Hakyll
import System.FilePath ((</>))

postCtx :: Context String
postCtx =
  dateField "date" "%B %e, %Y"
    `mappend` defaultContext

makeFeed :: Renderer -> Rules ()
makeFeed renderer = do
  route idRoute
  compile $ do
    let feedCtx = postCtx `mappend` bodyField "description"
    posts <-
      fmap (take 10) . recentFirst
        =<< loadAllSnapshots "posts/*" "content"
    renderer feed feedCtx posts

globbify :: FilePath -> Pattern
globbify dir = fromGlob $ dir </> "*"

compilePosts :: Compiler [Item String]
compilePosts = recentFirst =<< (loadAll . globbify) postsDir

hydrate :: Context String -> Compiler (Item String) -> Compiler (Item String)
hydrate context page = page >>= loadAndApplyTemplate defaultTemplate context >>= relativizeUrls

build :: Context String -> Compiler (Item String) -> Rules ()
build context = compile . hydrate context

make :: Compiler (Item String) -> Rules ()
make = compile . hydrate defaultContext

sameRoot :: Rules ()
sameRoot = route idRoute
