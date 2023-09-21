module Main where

import Graphics.Gloss

import Game
import Rendering as Show

-- janela do jogo
gameWindow = InWindow "Tic-tac-toe Functional - Grupo 01" (700, 525) (100, 100)

-- cor da janela do jogo
backgroundColor = makeColor 164 187 222 255

--o estado do jogo em uma imagem a ser exibida na tela como vazio
gameAsPicture _ = Blank

-- transforma o estado do jogo (não faz nada por enquanto)
transformGame _ game = game

main :: IO()
main = play gameWindow backgroundColor 30 initialGame Show.gameAsPicture transformGame (const id)
