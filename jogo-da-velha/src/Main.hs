module Main where

import Graphics.Gloss

-- cor da janela do jogo
backgroundColor = makeColor 164 187 222 255

--estado inicial do jogo
initialGame = 0

--o estado do jogo em uma imagem a ser exibida na tela
gameAsPicture _ = Blank

-- transforma o estado do jogo (não faz nada por enquanto)
transformGame _ game = game

-- janela do jogo
gameWindow = InWindow "Tic-tac-toe Functional - Grupo 01" (700, 525) (100, 100)

main :: IO()
main = play gameWindow backgroundColor 30 initialGame gameAsPicture transformGame (const id)
