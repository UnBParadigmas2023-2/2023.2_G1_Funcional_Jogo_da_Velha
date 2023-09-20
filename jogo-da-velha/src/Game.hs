module Game where

import Data.Array

data Player = PlayerX | PlayerO deriving (Eq, Show)
data Cell = Empty | Full Player deriving (Eq, Show)
data State = Running | GameOver (Maybe Player) deriving (Eq, Show)

type Board = Array (Int, Int) Cell

data Game = Game { gameBoard :: Board
                 , gamePlayer :: Player
                 , gameState :: State
                 } deriving (Eq, Show)


-- define o tamanho do tabuleiro 3x3
n :: Int
n = 3

--estado inicial do jogo
initialGame = Game { gameBoard = array indexRange $ zip (range indexRange) (repeat Nothing)
                   , gamePlayer = PlayerX
                   , gameState = Running
                   }
    where indexRange = ((0, 0), (n - 1, n - 1))
