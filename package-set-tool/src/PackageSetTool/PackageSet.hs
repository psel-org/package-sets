{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE OverloadedStrings #-}

module PackageSetTool.PackageSet (
    decoder,
    buildExpr,
    prettyPrint,
) where

import Dhall.Core qualified as DC
import Dhall.Map qualified as DM
import Dhall.Marshal.Decode qualified as D
import Dhall.Pretty qualified as DP
import PackageSetTool.Package
import Prettyprinter.Render.Text qualified
import RIO
import RIO.Seq qualified as Seq

-- そのままの形(一つのデカいrecord)ではなく,toMapでMap形式({ mapKey = ...,
-- mapValue = ... })をパッケーセットをデコードする。下記encoderとは純粋に対象的
-- な形ではないことに注意。
decoder :: D.Decoder [Package]
decoder = D.list $ conv <$> D.pairFromMapEntry D.strictText D.auto
  where
    conv (name, Package'{dependencies, repo, version}) =
        Package
            { name
            , dependencies
            , repo
            , version
            }

data Package' = Package'
    { dependencies :: [Text]
    , repo :: Text
    , version :: Text
    }
    deriving (Generic, Show)
    deriving (D.FromDhall)

-- toMap はあるがfromMap 組込関数はないためEncoder [Package]は(恐らく)書けない。
-- dhallは設定の読み込みがメインであり,書き出しは通常行なわないので当然と言えば
-- 当然である。
buildExpr :: [Package] -> DC.Expr Void Void
buildExpr =
    DC.RecordLit
        . DM.fromList
        . map
            ( \pkg ->
                ( packageKey pkg
                , DC.makeRecordField (packageExpr pkg)
                )
            )
  where
    packageKey Package{name} = name

    packageExpr Package{dependencies, repo, version} =
        DC.RecordLit $
            DM.fromList
                [ ("dependencies", DC.makeRecordField (dependenciesExpr dependencies))
                , ("repo", DC.makeRecordField (textExpr repo))
                , ("version", DC.makeRecordField (textExpr version))
                ]

    dependenciesExpr [] =
        DC.ListLit (Just DC.Text) mempty
    dependenciesExpr xs =
        DC.ListLit Nothing $ Seq.fromList $ map textExpr xs

    textExpr t = DC.TextLit (DC.Chunks [] t)

prettyPrint :: [Package] -> Text
prettyPrint =
    Prettyprinter.Render.Text.renderStrict
        . DP.layout
        . DP.prettyExpr
        . buildExpr
