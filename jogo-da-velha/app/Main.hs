module Main (main) where

import Lib
import Graphics.Gloss
import Graphics.Gloss.Data.Color

backgroundColor = makeColor 255 255 255 255
intialGame = undefined
transformGame _ game = game
gameAsPicture _ = blank
window = InWindow "Functional" (640, 480) (100, 100)

main :: IO ()
main = play backgroundColor 30 initialGama gameAsPicture (const id)