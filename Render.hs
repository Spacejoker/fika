module Render where

import Graphics.UI.SDL as SDL
import Graphics.UI.SDL.TTF as TTF
import Graphics.UI.SDL.Image as SDLi

import Model

render :: Game -> IO ()
render g = do
  s <- getVideoSurface

  --blitSurface (menubg gr) Nothing s (Just (Rect 0 0 800 600))
  SDL.flip s

