module Sor where

import Graphics.Gloss.Interface.IO.Game

import Sor.Variables
import Sor.Engine
import Sor.Levels


playSor :: IO ()
playSor =
  let win = InWindow "Summer Of Rogue" (gameWidth, gameHeight) (50, 50)
  in
    playIO win black 60 testLevel render handle update
