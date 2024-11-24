-- ln -s $(stack exec which cli-calc-exe) /usr/local/bin/calc

module Main (main) where

import System.Environment (getArgs)

main :: IO ()
main = do 
    args <- getArgs 
    case args of
        [input] -> putStrLn input
        _ -> putStrLn "Usage: calc <equation>"
