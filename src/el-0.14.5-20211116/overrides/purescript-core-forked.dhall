{ `assert` =
  { dependencies = [ "console", "effect", "prelude" ]
  , repo = "https://github.com/psel-org/purescript-assert.git"
  , version = "v5.0.0-el1"
  }
, console =
  { dependencies = [ "effect", "prelude" ]
  , repo = "https://github.com/psel-org/purescript-console.git"
  , version = "v5.0.0-el1"
  }
, control =
  { dependencies = [ "newtype", "prelude" ]
  , repo = "https://github.com/psel-org/purescript-control.git"
  , version = "v5.0.0-el2"
  }
, effect =
  { dependencies = [ "prelude" ]
  , repo = "https://github.com/psel-org/purescript-effect.git"
  , version = "v3.0.0-el1"
  }
, enums =
  { dependencies =
    [ "control"
    , "either"
    , "gen"
    , "maybe"
    , "newtype"
    , "nonempty"
    , "partial"
    , "prelude"
    , "tuples"
    , "unfoldable"
    ]
  , repo = "https://github.com/psel-org/purescript-enums.git"
  , version = "v5.0.0-el1"
  }
, foldable-traversable =
  { dependencies =
    [ "bifunctors"
    , "const"
    , "control"
    , "either"
    , "functors"
    , "identity"
    , "maybe"
    , "newtype"
    , "orders"
    , "prelude"
    , "tuples"
    ]
  , repo = "https://github.com/psel-org/purescript-foldable-traversable.git"
  , version = "v5.0.1-el1"
  }
, functions =
  { dependencies = [ "prelude" ]
  , repo = "https://github.com/psel-org/purescript-functions.git"
  , version = "v5.0.0-el1"
  }
, integers =
  { dependencies = [ "math", "maybe", "numbers", "prelude" ]
  , repo = "https://github.com/psel-org/purescript-integers.git"
  , version = "v5.0.0-el2"
  }
, math =
  { dependencies = [] : List Text
  , repo = "https://github.com/psel-org/purescript-math.git"
  , version = "v3.0.0-el3"
  }
, numbers =
  { dependencies = [ "functions", "math", "maybe" ]
  , repo = "https://github.com/psel-org/purescript-numbers.git"
  , version = "v8.0.0-el1"
  }
, partial =
  { dependencies = [] : List Text
  , repo = "https://github.com/psel-org/purescript-partial.git"
  , version = "v3.0.0-el1"
  }
, prelude =
  { dependencies = [] : List Text
  , repo = "https://github.com/psel-org/purescript-prelude.git"
  , version = "v5.0.1-el2"
  }
, refs =
  { dependencies = [ "effect", "prelude" ]
  , repo = "https://github.com/psel-org/purescript-refs.git"
  , version = "v5.0.0-el1"
  }
, unfoldable =
  { dependencies =
    [ "foldable-traversable", "maybe", "partial", "prelude", "tuples" ]
  , repo = "https://github.com/psel-org/purescript-unfoldable.git"
  , version = "v5.0.0-el1"
  }
, unsafe-coerce =
  { dependencies = [] : List Text
  , repo = "https://github.com/psel-org/purescript-unsafe-coerce.git"
  , version = "v5.0.0-el1"
  }
}
