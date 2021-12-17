{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeApplications #-}

module PackageSetTool.CommandListReverseDependencies (run) where

import Data.Graph (Graph, Vertex, graphFromEdges, reachable, topSort, transposeG)
import Dhall qualified
import PackageSetTool.Package
import PackageSetTool.PackageSet qualified as PackageSet
import RIO
import RIO.Text (isPrefixOf, unpack)
import System.IO (print, putStrLn)

run :: HasLogFunc env => Text -> Text -> RIO env ()
run packageDhall packageName = do
    ps <- liftIO $ Dhall.input PackageSet.decoder ("toMap (" <> packageDhall <> ")")
    let (graph, getPackage, getVertex) = mkPackageGraph ps
    case getVertex packageName of
        Just vtx -> do
            let rvgraph = transposeG graph
            let revdeps = reachable rvgraph vtx
            logInfo $ display $ length revdeps
            forM_ revdeps $ \v -> do
                let (package, name, _) = getPackage v
                logInfo $ display name
        Nothing -> do
            logError "Package is not included in package set."
