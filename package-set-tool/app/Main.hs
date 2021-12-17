{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Options.Generic (ParseRecord (parseRecord), getRecord, lispCaseModifiers, parseRecordWithModifiers)
import PackageSetTool.CommandCopy qualified as CommandCopy
import PackageSetTool.CommandListReverseDependencies qualified as CommandListReverseDependencies
import RIO

data Command
    = ListReverseDependencies Text Text
    | ListDependencies Text Text
    | Copy Text Text [Text]
    deriving (Generic, Show)

instance ParseRecord Command where
    parseRecord = parseRecordWithModifiers lispCaseModifiers

main :: IO ()
main = do
    cmd <- getRecord "package-set-tool"
    runSimpleApp $ do
        case cmd of
            ListReverseDependencies packageDhall packageName ->
                CommandListReverseDependencies.run packageDhall packageName
            ListDependencies packageDhall packageName ->
                pure ()
            Copy fromPackageDhall toPackageDhall packageNames ->
                CommandCopy.run fromPackageDhall toPackageDhall packageNames
