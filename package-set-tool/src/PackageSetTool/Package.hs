{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}

module PackageSetTool.Package where

import Data.Graph (Graph, Vertex, graphFromEdges)
import Dhall qualified
import RIO
import RIO.Text (isPrefixOf)

data Package = Package
    { name :: Text
    , dependencies :: [Text]
    , repo :: Text
    , version :: Text
    }
    deriving (Generic, Show)
    deriving (Dhall.FromDhall)

isCoreLibrary :: Package -> Bool
isCoreLibrary Package{repo} =
    "https://github.com/purescript/" `isPrefixOf` repo

isContribLibrary :: Package -> Bool
isContribLibrary Package{repo} =
    "https://github.com/purescript-contrib/" `isPrefixOf` repo

mkPackageGraph ::
    [Package] ->
    ( Graph
    , Vertex -> (Package, Text, [Text])
    , Text -> Maybe Vertex
    )
mkPackageGraph = graphFromEdges . map toNode
  where
    toNode package@Package{name, dependencies} = (package, name, dependencies)
