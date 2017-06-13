{-# LANGUAGE OverloadedStrings #-}

-- | This module contains function to handle file download
module Download where

import qualified Data.ByteString.Char8 as Char8ByteString
import qualified Data.ByteString.Lazy as LazyByteString
import Network.Wai
import Network.Wai.Parse
import Network.HTTP.Types
import System.Environment
import System.FilePath
import System.Directory

import Responses


DownloadFile :: FilePart

