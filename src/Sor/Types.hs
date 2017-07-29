module Sor.Types where

import qualified Data.Map as Map

import Graphics.Gloss.Interface.IO.Game


type KeyMap = Map.Map Key KeyState

data GameObject = GameObject { posX :: Int
                             , posY :: Int
                             , visual :: Picture
                             , controlled :: Bool
                             , blocks :: Bool
                             } deriving Show

data Game = Game { objects :: [GameObject]
                 , updateF :: Float -> Game -> IO Game
                 , keyMap :: KeyMap
                 }

defaultGameObject :: GameObject
defaultGameObject = GameObject 0 0 (Color red $ circleSolid 5) False False

defaultGame :: Game
defaultGame = Game { objects = []
                   , updateF = (\dt g -> return g)
                   , keyMap = Map.empty}
