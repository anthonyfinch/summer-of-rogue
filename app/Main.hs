module Main where

import Graphics.Gloss

-- | Display the last event received as text.
main = play
  (InWindow "Summer Of Rogue" (700, 100) (50, 50)) -- display specification
  white -- background colour
  100 -- target fps
  "" -- initial state
  (\str -> Translate (-340) 0 $ Scale 0.1 0.1 $ Text str) -- draw function
  (\event _ -> show event) -- event handler
  (\_ world -> world) -- update function
