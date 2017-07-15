module Sor where

import Graphics.Gloss.Interface.IO.Game

playSor = playIO
  (InWindow "Summer Of Rogue" (700, 100) (50, 50))
  white
  100
  ""
  (\str -> return (Translate (-340) 0 $ Scale 0.1 0.1 $ Text str))
  (\event _ -> return (show event))
  (\_ world -> return world)
