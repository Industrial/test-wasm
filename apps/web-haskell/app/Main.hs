{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty


main :: IO ()
main = scotty 3030 $
    get "/:word" $ do
        beam <- param "word"
        html $ mconcat ["<h1>Scotty, ", beam, " me up!</h1>"]