module Logic where

import Data.Array
import Data.Foldable (asum)

import Game
import Graphics.Gloss.Interface.Pure.Game

-- Verifica se as coordenadas são corretas
isCoordCorrect :: (Int, Int) -> Bool
isCoordCorrect = inRange ((0, 0), (n - 1, n - 1))

-- Alterna o jogador atual
switchPlayer :: Game -> Game
switchPlayer game =
    case gamePlayer game of
      PlayerX -> game { gamePlayer = PlayerO }
      PlayerO -> game { gamePlayer = PlayerX }

-- Verifica se uma lista de células está completamente ocupada pelo mesmo jogador
full :: [Cell] -> Maybe Player
full (cell@(Full player):cells) | all (== cell) cells = Just player
full _                                                = Nothing

-- Determina o vencedor do jogo
winner :: Board -> Maybe Player
winner board = asum $ map full $ rows ++ cols ++ diags
    where rows  = [[board ! (i,j) | i <- [0..n-1]] | j <- [0..n-1]]
          cols  = [[board ! (j,i) | i <- [0..n-1]] | j <- [0..n-1]]
          diags = [[board ! (i,i) | i <- [0..n-1]]
                  ,[board ! (i,j) | i <- [0..n-1], let j = n-1-i ]]

-- Conta o número de células preenchidas com um determinado valor no tabuleiro
countCells :: Cell -> Board -> Int
countCells cell = length . filter ((==) cell) . elems

countEmptyCells :: Board -> Int
countEmptyCells = countCells Empty

-- Verifica se o jogo acabou
checkGameOver :: Game -> Game
checkGameOver game
    | Just p <- winner tabuleiro =
        game { gameState = GameOver $ Just p }
    | countEmptyCells tabuleiro == 0 =
        game { gameState = GameOver Nothing }
    | otherwise = game
    where tabuleiro = gameBoard game

-- Função que representa a vez de um jogador
playerTurn :: Game -> (Int, Int) -> Game
playerTurn game cellCoord
    | isCoordCorrect cellCoord && board ! cellCoord == Empty =
        checkGameOver
        $ switchPlayer
        $ game { gameBoard = board // [(cellCoord, Full player)] }
    | otherwise = game
    where board = gameBoard game
          player = gamePlayer game

-- Converte a posição do mouse em coordenadas da célula
mousePosAsCellCoord :: (Float, Float) -> (Int, Int)
mousePosAsCellCoord (x, y) = ( floor ((y + (fromIntegral screenHeight * 0.5)) / cellHeight)
                             , floor ((x + (fromIntegral screenWidth * 0.5)) / cellWidth)
                             )

-- Função que transforma o estado do jogo com base em eventos de teclado/mouse
transformGame :: Event -> Game -> Game
transformGame (EventKey (MouseButton LeftButton) Up _ mousePos) game =
    case gameState game of
      Running -> playerTurn game $ mousePosAsCellCoord mousePos
      GameOver _ -> initialGame
transformGame _ game = game
