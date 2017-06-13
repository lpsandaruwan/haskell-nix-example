{-# LANGUAGE OverloadedStrings #-}

module Main where

import Network.Wai
import Network.Wai.Handler.Warp

import Download
import Responses
import Upload

main :: IO ()


-- Run app server
main = do
    putStrLn $ "Server running at port 4000"
    run 4000 mainApp


-- Main application, route paths
mainApp :: Application
mainApp req send =
    case pathInfo req of
        []                  -> send $ serverStatus
        ["files/save"]      -> uploadFile req send
        _                   -> send $ errorRoute