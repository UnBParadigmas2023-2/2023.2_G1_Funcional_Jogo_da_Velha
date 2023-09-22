module Main where

import Graphics.Gloss
import Graphics.Gloss.Data.Color
import Game
import Rendering
import Logic

-- janela do jogo
gameWindow = InWindow "Tic-tac-toe Functional - Grupo 01" (screenWidth, screenHeight) (100, 100)

-- cor da janela do jogo
backgroundColor = makeColor 0 0 0 255

-- --o estado do jogo em uma imagem a ser exibida na tela como vazio
-- gameAsPicture _ = Blank

-- -- transforma o estado do jogo (não faz nada por enquanto)
-- transformGame _ game = game



main :: IO()
main = play gameWindow backgroundColor 30 initialGame gameAsPicture transformGame (const id)
