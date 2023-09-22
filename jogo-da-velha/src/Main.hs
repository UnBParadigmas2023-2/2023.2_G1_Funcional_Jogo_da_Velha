module Main where

import Graphics.Gloss
import Graphics.Gloss.Data.Color
import Game
import Rendering
import Logic
import Graphics.Gloss.Interface.Pure.Game
import Text.Read (readMaybe)  -- Para converter uma String em Maybe Int
data AppState = AppState
    { inputValue :: String
    , result :: String
    }

initialState :: AppState
initialState = AppState "" ""

-- janela do jogo
gameWindow = InWindow "Jogo da Velha Functional - Grupo 01" (screenWidth, screenHeight) (100, 100)
-- gameWindow = InWindow "Inserir Numero" (screenWidth, screenHeight) (100, 100)

-- cor da janela do jogo
backgroundColor = makeColor 0 0 0 255

-- --o estado do jogo em uma imagem a ser exibida na tela como vazio
-- gameAsPicture _ = Blank

-- -- transforma o estado do jogo (não faz nada por enquanto)
-- transformGame _ game = game



main :: IO()
main = play gameWindow backgroundColor 30 initialGame gameAsPicture transformGame (const id)
-- main = play gameWindow white 50 initialState draw handleEvent update 

draw :: AppState -> Picture
draw appState = pictures
    [ translate (-150) 20 $ scale 0.2 0.2 $ text "Insira um numero:"
    , translate (-40) (-20) $ scale 0.2 0.2 $ text (inputValue appState)
    , translate (-60) (-60) $ scale 0.2 0.2 $ text (result appState)
    ]

handleEvent :: Event -> AppState -> AppState
handleEvent (EventKey (Char c) Down _ _) appState =
    appState { inputValue = inputValue appState ++ [c] }
handleEvent (EventKey (SpecialKey KeyEnter) Down _ _) appState =
    case readMaybe (inputValue appState) :: Maybe Int of
        Just num -> appState { inputValue = "", result = "Numero inserido: " ++ show num }
        Nothing  -> appState { result = "Entrada invalida", inputValue = "" }
handleEvent e appState = appState

update :: Float -> AppState -> AppState
update _ appState = appState