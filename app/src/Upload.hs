{-# LANGUAGE OverloadedStrings #-}

-- | This module contains function to handle file upload
module Upload where

import qualified Data.ByteString.Char8 as Char8ByteString
import qualified Data.ByteString.Lazy as LazyByteString
import Network.Wai
import Network.Wai.Parse
import Network.HTTP.Types
import System.Environment
import System.FilePath
import System.Directory

import Responses


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

            -- Action on successful file upload
            send $ uploadSuccessful
