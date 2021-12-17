{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

module PackageSetTool.CommandListCoreLibraries (run) where

import Data.Graph (Graph, Vertex, graphFromEdges, topSort)
import Dhall qualified
import PackageSetTool.Package
import PackageSetTool.PackageSet qualified as PackageSet
import RIO
import RIO.Text (isPrefixOf, unpack)
import System.IO (print, putStrLn)

run :: Text -> Text -> IO ()
run packageDhall packageName = do
    ps <- Dhall.input PackageSet.decoder ("toMap (" <> packageDhall <> ")")
    let (graph, getNode, getVertex) = mkPackageGraph $ filter isCoreLibrary ps
    print $ length ps
    forM_ (reverse $ topSort graph) $ \vtx -> do
        let (Package{name}, _, _) = getNode vtx
        putStrLn $ unpack name
