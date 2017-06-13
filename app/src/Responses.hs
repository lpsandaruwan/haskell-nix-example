{-# LANGUAGE OverloadedStrings #-}

-- | This module contains common HTTP responses
module Responses where

import Network.Wai
import Network.HTTP.Types


-- Path not found response
errorRoute :: Response

errorRoute =
    responseLBS
    status404
    [("Content-Type", "text/plain; charset=utf-8")]
    "404 - Not found"


-- File not found response
fileNotFound :: Response

fileNotFound =
    responseLBS
    status400
    [("Content-Type", "text/plain; charset=utf-8")]
    "File not found"


-- Server status response
serverStatus :: Response

serverStatus =
    responseLBS
    status200
    [("Content-Type", "text/plain; charset=utf-8")]
    "File server is running"


-- Response on successful file upload
uploadSuccessful :: Response

uploadSuccessful =
    responseLBS
    status303
    [("Content-Type", "text/plain: charset=utf-8"), ("Location", "/")]
    "Upload successful!"
