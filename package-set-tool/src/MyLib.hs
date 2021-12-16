{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

module MyLib (defaultMain) where

import Data.Graph (graphFromEdges, topSort)
import Dhall qualified
import RIO
import RIO.Text (unpack, isPrefixOf)
import System.IO (putStrLn)

data Package = Package
    { name :: Text
    , dependencies :: [Text]
    , repo :: Text
    , version :: Text
    }
    deriving (Generic, Show)
    deriving (Dhall.FromDhall)

isCoreLibrary :: Package -> Bool
isCoreLibrary Package{repo} = isPrefixOf "https://github.com/purescript-contrib/" repo

defaultMain :: IO ()
defaultMain = do
    vs <- Dhall.input (Dhall.list (Dhall.auto @Package)) "./dhall/packages.dhall"
    let toNode package@Package{name, dependencies} = (package, name, dependencies)
    let coreLibraries = filter isCoreLibrary vs
    let (graph, getNode, getVertex) = graphFromEdges $ map toNode coreLibraries
    putStrLn . show $ length vs
    forM_ (reverse $ topSort graph) $ \vtx -> do
        let (Package{name}, _, _) = getNode vtx
        putStrLn $ unpack name
    pure ()
