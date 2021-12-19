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
  , version = "v5.0.0-el1"
  }
, effect =
  { dependencies = [ "prelude" ]
  , repo = "https://github.com/psel-org/purescript-effect.git"
  , version = "v3.0.0-el1"
  }
, prelude =
  { dependencies = [] : List Text
  , repo = "https://github.com/psel-org/purescript-prelude.git"
  , version = "v5.0.1-el1"
  }
, unsafe-coerce =
  { dependencies = [] : List Text
  , repo = "https://github.com/psel-org/purescript-unsafe-coerce.git"
  , version = "v5.0.0-el1"
  }
}
