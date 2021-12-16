# package-sets for psel

WIP(no releases yet)

Currently working on package-sets based on `psc-0.14.5-20211116/packages.dhall`.
If you want to use this package-sets, specify following url as `packages` in spago.dhall.

    https://raw.githubusercontent.com/psel-org/package-sets/main/src/el-0.14.5-20211116/packages.dhall

Once you build, spago will add sha256 hash after the url.
If you want to retrieve the latest change, remove the sha256 hash and run `spago build`.
