module Sor.Engine where

import qualified Data.Map as Map

import Graphics.Gloss.Interface.IO.Game

import Sor.Types
import Sor.Variables


--
-- Grid Functions
--

gridToPos :: Int -> Float
gridToPos i = fromIntegral i * tileSize


--
-- Rendering
--

renderGameObject :: GameObject -> Picture
renderGameObject go =
  Translate goX goY $ goPicture
  where
    goX = gridToPos $ posX go
    goY = gridToPos $ posY go
    goPicture = visual go


render :: Game -> IO Picture
render game = return (pictures $ map renderGameObject (objects game))


--
-- Simulation
--

update :: Float -> Game -> IO (Game)
update dt game@(Game _ updateF _ _) = updateF dt game


--
-- Event Handling
--

handle :: Event -> Game -> IO (Game)
handle (EventKey key state _ _) game = return (game { keyMap = Map.insert key state (keyMap game)} )
handle _ game = return game
