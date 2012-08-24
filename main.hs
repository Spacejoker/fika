import Graphics.UI.SDL as SDL
import Graphics.UI.SDL.TTF as TTF
import Graphics.UI.SDL.Image as SDLi

import System.Random
import Data.Time.Clock

import Render
import Model

main = do
  SDL.init [InitEverything]
  setVideoMode 1024 800 32 []
  TTF.init

  setCaption "Fika" "Fika" 

  enableKeyRepeat 500 30

  stdGen <- getStdGen 
  testimage <- SDLi.load "images/quit4.png"
 
  time <- getCurrentTime 
  let constants = GameConstants 200 200
  let g = Game True time time constants
  gameLoop (Game True time time)

gameLoop :: Game -> IO ()
gameLoop g = do
  delay 10
 
  g' <- if True then handleLogic g else return g
  if True then render g' else return ()

  case active g' of
    True -> gameLoop g'
    _ -> return ()

handleLogic :: Game -> IO Game
handleLogic g = do

  -- always handle user input
  events <- getEvents pollEvent []
  let g' = handleEvents events g

  time <- getCurrentTime
  
  let diff = (diffUTCTime time (lastLogicTick g))* 1000
  case diff > (millisBetweenLogic (constants g))  of
    True -> logicTick g'
    _ -> return g'

logicTick :: Game -> IO Game
logicTick g = do
  putStrLn "Tick"
  time <- getCurrentTime
  
  return g {lastLogicTick = time}

getEvents :: IO Event -> [Event] -> IO [Event]
getEvents pEvent es = do
  e <- pEvent
  case e of
    NoEvent -> return (reverse es)
    _ -> getEvents pEvent (e:es)

handleEvents :: [Event] -> Game -> Game
handleEvents [] g = g
handleEvents (x:xs) g = 
  let g' = case x of
             KeyDown (Keysym SDLK_SPACE _ _) -> g {active = False}
             _ -> g
  in handleEvents xs g'
    
