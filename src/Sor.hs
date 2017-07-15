module Sor where

import Graphics.Gloss.Interface.IO.Game


data GridCoord = GridCoord
  {
    x :: Int,
    y :: Int
  }

data Player =  Player
  {
    position :: GridCoord
  }

data GameState = GameState
  {
    player :: Player
  }


gameWidth = 800
gameHeight = 600
tileSize = 10

initialGameState = GameState
  {
    player = Player $ GridCoord 0 0
  }

gridToPos :: Int -> Float
gridToPos i = fromIntegral i * tileSize

render :: GameState -> IO Picture
render state = return (Translate px py $ Color white $ circleSolid tileSize)
  where
    pos = position $ player state
    px = gridToPos $ x $ pos
    py = gridToPos $ y $ pos

handleEvent :: Event -> GameState -> IO GameState
handleEvent event state = return state

update :: Float -> GameState -> IO GameState
update dt state = return state

playSor :: IO ()
playSor = playIO
  (InWindow "Summer Of Rogue" (gameWidth, gameHeight) (50, 50))
  black
  60
  initialGameState
  render
  handleEvent
  update
