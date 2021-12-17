{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE OverloadedStrings #-}

module PackageSetTool.CommandCopy (run) where

import Data.Graph (Graph, Vertex, graphFromEdges, reachable, topSort, transposeG)
import Dhall qualified
import PackageSetTool.Package
import PackageSetTool.PackageSet qualified as PackageSet
import RIO
import RIO.Map qualified as Map
import RIO.Text (isPrefixOf, unpack)
import System.IO (print, putStrLn)

run :: HasLogFunc env => Text -> Text -> [Text] -> RIO env ()
run fromPackageDhall toPackageDhall packageNames = do
    fromPs <- liftIO $ Dhall.input PackageSet.decoder ("toMap (" <> fromPackageDhall <> ")")
    toPs <- liftIO $ Dhall.input PackageSet.decoder ("toMap (" <> toPackageDhall <> ")")
    let pmap = mkPackageMap fromPs
    let pkgs = mapMaybe (`Map.lookup` pmap) packageNames
    writeFileUtf8 (unpack toPackageDhall)
        . PackageSet.prettyPrint
        $ PackageSet.sortOnName (pkgs <> toPs)
