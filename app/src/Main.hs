{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Data.ByteString.Char8 as Char8ByteString
import qualified Data.ByteString.Lazy as LazyByteString
import Data.Functor.Identity
import Network.Wai
import Network.Wai.Application.Static
import Network.Wai.Handler.Warp
import Network.Wai.Parse
import Network.HTTP.Types
import System.Environment
import System.FilePath
import System.Directory


main :: IO ()


-- Run app server
main = do
    putStrLn $ "Server running at port 4000"
    run 4000 mainApp


-- Server status response
serverStatus :: Response
serverStatus =
    responseLBS
    status200
    [("Content-Type", "text/plain; charset=utf-8")]
    "File server is running"


-- File not found response
fileNotFound :: Response
fileNotFound =
    responseLBS
    status400
    [("Content-Type", "text/plain; charset=utf-8")]
    "File not found"


-- Response on successfull file upload
uploadSuccessful :: Response
uploadSuccessful =
    responseLBS
    status303
    [("Content-Type", "text/plain: charset=utf-8"), ("Location", "/")]
    "Upload successful!"


-- Path not found response
errorRoute :: Response
errorRoute =
    responseLBS
    status404
    [("Content-Type", "text/plain; charset=utf-8")]
    "404 - Not found"


-- Handling file uploads and save in current directory
uploadFile :: Application
uploadFile req send = do
    (_params, files) <- parseRequestBody lbsBackEnd req

    -- Check and prompt action if file is in request body
    case lookup "file" files of
        Nothing -> send $ fileNotFound

        Just file -> do
            -- Save file content
            let
                name = takeFileName $ Char8ByteString.unpack $ fileName file
                content = fileContent file
            LazyByteString.writeFile name content

            -- Action on successfull file upload
            send $ uploadSuccessful


-- Main application, route paths
mainApp :: Application
mainApp req send =
    case pathInfo req of
        []                  -> send $ serverStatus
        ["files/save"]      -> uploadFile req send
        _                   -> send $ errorRoute


