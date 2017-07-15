module Sor where

import Graphics.Gloss.Interface.IO.Game


data GridCoord = GridCoord
  {
    gridX :: Int,
    gridY :: Int
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
tileSize = 20

initialGameState = GameState
  {
    player = Player $ GridCoord 0 0
  }

gridToPos :: Int -> Float
gridToPos i = fromIntegral i * tileSize

render :: GameState -> IO Picture
render state = return (Translate px py $ Color white $ circleSolid (tileSize / 2))
  where
    pos = position $ player state
    px = gridToPos $ gridX $ pos
    py = gridToPos $ gridY $ pos

movePlayer :: Int -> Int -> GameState -> GameState
movePlayer x y state = state
  {
    player = play
  }
  where
    play' = player state
    pos' = position $ play'
    pos = GridCoord (gridX pos' + x) (gridY pos' + y)
    play = play'
      {
        position = pos
      }

handleEvent :: Event -> GameState -> IO GameState
handleEvent (EventKey (SpecialKey KeyDown) Down _ _) state = return (movePlayer 0 (-1) state)
handleEvent (EventKey (SpecialKey KeyUp) Down _ _) state = return (movePlayer 0 1 state)
handleEvent (EventKey (SpecialKey KeyLeft) Down _ _) state = return (movePlayer (-1) 0 state)
handleEvent (EventKey (SpecialKey KeyRight) Down _ _) state = return (movePlayer 1 0 state)
handleEvent _ state = return state

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
