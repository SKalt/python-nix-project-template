# adapted from https://github.com/JRMurr/roc2nix/blob/main/lib/languageFilters.nix
{ lib }:

# common file sets for different languages
# https://nix.dev/tutorials/file-sets
# https://nixos.org/manual/nixpkgs/unstable/#sec-functions-library-fileset
with lib.fileset;

let

  fileHasAnySuffix = fileSuffixes: file: (lib.lists.any (s: lib.hasSuffix s file.name) fileSuffixes);

  python = basePath: (
    let
      mainFilter = fileFilter
        (fileHasAnySuffix [
          ".py"
          "pyproject.toml" "poetry.lock"
          "requirements.txt"
          "Pipfile" "Pipfile.lock"
        ])
        basePath;
    in
    unions [ mainFilter (basePath + "/pyproject.toml") (basePath + "/poetry.lock") ]
  );
  in
{
  inherit python;
}
