{ prelude =
  { dependencies = [] : List Text
  , repo = "https://github.com/psel-org/purescript-prelude.git"
  , version = "v5.0.1-el1"
  }
, effect =
  { dependencies = [ "prelude" ] : List Text
  , repo = "https://github.com/psel-org/purescript-effect.git"
  , version = "v3.0.0-el1"
  }
}
