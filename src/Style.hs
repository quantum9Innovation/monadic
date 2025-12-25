module Style where

import Data.Text.Lazy as TL
import Clay
import Constants
import qualified Clay.Media as Media
import qualified Clay.FontFace as FF

abordage :: Css
abordage = fontFace $ do
  fontFamily ["Abordage"] []
  fontFaceSrc [ FF.FontFaceSrcUrl "../fonts/degheest/Abordage-Regular.otf" (Just FF.OpenType) ]
  fontWeight normal
  fontStyle normal 
  
latitude :: Css
latitude = fontFace $ do
  fontFamily ["Latitude"] []
  fontFaceSrc [ FF.FontFaceSrcUrl "../fonts/degheest/Latitude-Regular.otf" (Just FF.OpenType) ]
  fontWeight normal
  fontStyle normal
  
libertinus :: Css
libertinus = fontFace $ do
  fontFamily ["Libertinus"] []
  fontFaceSrc [ FF.FontFaceSrcUrl "../fonts/libertinus/LibertinusSerif-Regular.ttf" (Just FF.TrueType) ]
  fontWeight normal
  fontStyle normal
  
lilex :: Css
lilex = fontFace $ do
  fontFamily ["Lilex"] []
  fontFaceSrc [ FF.FontFaceSrcUrl "../fonts/lilex/Lilex-Regular.otf" (Just FF.OpenType) ]
  fontWeight normal
  fontStyle normal
 
fonts :: Css
fonts = do
  abordage
  latitude
  libertinus
  lilex
  
uniformLinkStyle :: Css
uniformLinkStyle = do
  textDecoration none
  color deepblue
  
styles :: Css
styles = do
  fonts
  
  ".image-link" ? uniformLinkStyle
  
  "::selection" ? do
    backgroundColor deepblue
    color white

  html ? do
    fontSize (pct 62.5)
    fontFamily ["Libertinus"] []
    
  body ? do
    fontSize (Clay.rem 2)
    color black
    
  p ? do
    fontFamily ["Libertinus"] []
    fontSize (Clay.rem 1.8)
    color black
    
  a ? do
    color deepblue
    textDecoration none
    ":visited" & color deepblue
    ":hover" & textDecoration underline
    ":active" & textDecoration underline
    ":focus" & textDecoration underline
    
  blockquote ? do
    color darkgray
    borderLeft (Clay.rem 0.2) solid gray
    paddingLeft (Clay.rem 1)

    p ? do
      fontFamily ["Libertinus"] []
      fontSize (Clay.rem 2.4)
      maxWidth (Clay.rem 50)
    
    ".quote" ? do
      textAlign start
    
    ".attr" ? do
      textAlign end
    
  header ? do
    height (Clay.rem 5)
    borderBottom (Clay.rem 0.2) solid black
    
  nav ? do
    paddingTop (Clay.rem ((5 - 2.2) / 2))
    textAlign end
    a ? do
      fontFamily ["Latitude"] []
      fontSize (Clay.rem 2.2)
      color black
      textDecoration none
      ":visited" & color black
  
  footer ? do
    fontFamily ["Latitude"] []
    marginTop (Clay.rem 3)
    padding (Clay.rem 1.2) (Clay.rem 0) (Clay.rem 1.2) (Clay.rem 0)
    borderTop (Clay.rem 0.2) solid black
    fontSize (Clay.rem 1.4)
    color "#555"
    
  h1 ? do
    fontFamily ["Abordage"] []
    fontSize (Clay.rem 7.5)
    marginBottom (px 0)
    
  h2 ? do
    fontFamily ["Abordage"] []
    fontSize (Clay.rem 5)
    marginBottom (px 0)
    
  h3 ? do
    fontFamily ["Abordage"] []
    fontSize (Clay.rem 3)
    
  "#main-content" ? do
    display flex
    justifyContent Clay.center
    alignItems Clay.center
    ".subtitle" ? do
      display inlineBlock
      width (pct 75)
      marginLeft (px 0)
      marginRight (pct 5)
      verticalAlign middle
    
  ".username" ? do
    fontFamily ["Lilex"] []
    fontSize (Clay.rem 2.4)
    
    ":hover" & do
      ".username-tooltip" ? do
        visibility visible
    
    a ? do
      uniformLinkStyle
      ":hover" & textDecoration underline
      ":visited" & uniformLinkStyle
      ":active" & textDecoration underline
      ":focus" & textDecoration underline
  
  ".username-tooltip" ? do
    visibility hidden
    width fitContent
    fontSize (Clay.rem 1.6)
    borderRadius (px 5) (px 5) (px 5) (px 5)
    paddingLeft (px 5)
    paddingRight (px 5)
    backgroundColor black
    color white
    position relative
    left (px 10)
    zIndex 1
    
  ".subtitle" ? do
    fontFamily ["Libertinus"] []
    fontSize (Clay.rem 2.5)
    
  article ? do
    ".header" ? do
      fontSize (Clay.rem 1.4)
      fontStyle italic
      color "#555"
      
  ".logo" ? do 
    a ? do
      fontSize (Clay.rem 2.2)
      fontFamily ["Latitude"] []
      marginTop (Clay.rem ((5 - 2.2) / 2))
      marginLeft (px 15)
      textDecoration none
      color black
      
      ":hover" & do
        backgroundColor black
        color white
      
  "#icon" ? do
    float floatLeft
    height (Clay.rem 4)
    borderRadius (pct 50) (pct 50) (pct 50) (pct 50)
      
  ".left" ? do
    textAlign start
      
  "#main-image" ? do
    display inlineBlock
    width (pct 20)
    margin (px 0) (px 0) (px 0) (px 0)
    borderRadius (px 20) (px 20) (px 20) (px 20)
    
  query Media.screen [Media.maxWidth (px 319)] $ do
    body ? do
      width (pct 90)
      margin (px 0) (px 0) (px 0) (px 0)
      padding (pct 0) (pct 0) (pct 5) (pct 5)
    
    header ? do
      borderBottom (px 0) solid black
      margin (Clay.rem 4.2) (Clay.rem 0) (Clay.rem 4.2) (Clay.rem 0)
    
    nav ? do
      margin (Clay.rem 0) auto (Clay.rem 3) (Clay.rem 3)
      textAlign Clay.center
    
    footer ? do
      textAlign start
      
    ".logo" ? do
      textAlign Clay.center
      margin (Clay.rem 1) auto (Clay.rem 3) (Clay.rem 3)
      
      a ? do
        fontSize (Clay.rem 2.4)
    
    nav ? a ? do
      display block
      lineHeight (Clay.rem (2.4 * 1.6))
 
  query Media.screen [Media.minWidth (px 320)] $ do
    body ? do
      width (pct 90)
      margin (px 0) (px 0) (px 0) (px 0)
      padding (pct 0) (pct 0) (pct 5) (pct 5)
    
    header ? do
      borderBottom (px 0) solid black
      margin (Clay.rem 4.2) (Clay.rem 0) (Clay.rem 0) (Clay.rem 4.2)
    
    nav ? do
      margin (Clay.rem 0) auto (Clay.rem 3) (Clay.rem 3)
      a ? do
        display inline
        margin (Clay.rem 0) (Clay.rem 0.6) (Clay.rem 0) (Clay.rem 0.6)
    
    footer ? do
      textAlign start
    
    ".logo" ? do
      textAlign Clay.center
      margin (Clay.rem 1) auto (Clay.rem 3) (Clay.rem 3)
    
      a ? do
        fontSize (Clay.rem 2.4)
    
  query Media.screen [Media.minWidth (px 640)] $ do
    body ? do
      width (Clay.rem 60)
      margin (px 0) auto auto (px 0)
    
    header ? do
      margin (Clay.rem 3) (Clay.rem 0) (Clay.rem 3) (Clay.rem 0)
    
    nav ? do
      margin (px 0) (px 0) (px 0) (px 0)
      a ? do
        display inline
        margin (Clay.rem 0) (Clay.rem 0.6) (Clay.rem 0) (Clay.rem 0.6)
    
    footer ? do
      textAlign start
    
    ".logo" ? do
      textAlign Clay.center
      margin (Clay.rem 1) auto (Clay.rem 3) (Clay.rem 3)
    
      a ? do
        fontSize (Clay.rem 2.4)
    
  query Media.screen [Media.minWidth (px 1024)] $ do
    body ? do
      width (Clay.rem 80)
      margin (px 0) auto (px 0) auto
    
    header ? do
      borderBottom (Clay.rem 0.2) solid black
      margin (Clay.rem 3) (Clay.rem 0) (Clay.rem 3) (Clay.rem 0)
    
    nav ? do
      margin (px 0) (px 0) (px 0) (px 0)
      a ? do
        display inline
        margin (Clay.rem 0) (Clay.rem 0) (Clay.rem 0) (Clay.rem 1.2)
    
    footer ? do
      textAlign end
    
    ".logo" ? do
      margin (px 0) (px 0) (px 0) (px 0)
      textAlign start
    
      a ? do
        float floatLeft
        fontSize (Clay.rem 2.2)
    
css :: String
css = TL.unpack $ renderWith compact [] styles
