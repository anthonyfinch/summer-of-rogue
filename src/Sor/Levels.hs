module Sor.Levels where

import qualified Data.Map as Map

import Graphics.Gloss.Interface.IO.Game

import Sor.Types
import Sor.Variables


mapIf :: (a -> Bool) -> (a -> a) -> [a] -> [a]
mapIf cond f as = map (\a -> if cond a then f a else a) as

keyDown :: KeyMap -> Key -> Bool
keyDown km key = Map.findWithDefault Up key km == Down

getMovementDir :: KeyMap -> (Int, Int)
getMovementDir km = (,)
                    (if keyDown km (Char 'a') then
                       -1
                     else if keyDown km (Char 'd') then
                        1
                     else
                        0)
                    (if keyDown km (Char 'w') then
                       1
                     else if keyDown km (Char 's') then
                        -1
                     else
                        0)


move :: Game -> GameObject -> GameObject
move game go = if canMove (newX, newY)
               then go { posX = newX, posY = newY }
               else go
  where
    objs = objects game
    (x, y) = getMovementDir $ keyMap game
    newX = posX go + x
    newY = posY go + y
    canMove (x, y) = all (\obj -> if (posX obj == x && posY obj == y && blocks obj) then False else True) objs


handleMovementKeys :: Game -> Game
handleMovementKeys game@(Game objects _ keyMap _) =

  if any (\k -> Map.findWithDefault Up k keyMap == Down) [Char 'w', Char 'a', Char 's', Char 'd']
  then
    game{ objects = mapIf controlled (move game) objects }
  else
    game


cleanKeyState :: Game -> Game
cleanKeyState game = game { keyMap = Map.empty }


updateLevel :: Float -> Game -> IO Game
updateLevel dt game = return (cleanKeyState $ handleMovementKeys game)

updateLoadingLevel :: Float -> Game -> IO Game
updateLoadingLevel dt game = if counter game <= 0
                             then
                               return testLevel
                             else
                               return game { counter = counter game - 1 }


player = defaultGameObject { visual = Color white $ circle (tileSize / 2)
                           , controlled = True
                           }

testObject = defaultGameObject { posX = 2
                               , posY = 2
                               , visual = Color red $ circle (tileSize / 2)
                               , blocks = True
                               }

testLevel = defaultGame { objects = [player, testObject]
                        , updateF = updateLevel
                        }

loadingLevel = defaultGame { updateF = updateLoadingLevel
                           , counter = 60
                           }
