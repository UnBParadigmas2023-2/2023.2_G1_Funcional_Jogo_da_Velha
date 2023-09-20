import Graphics.Gloss

main :: IO ()
main = display (InWindow "Teste Gloss" (200, 200) (10, 10)) white (Circle 50)
