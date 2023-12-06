let
    systems' =
      (builtins.foldl' (b: a: {${a} = a;} // b) {}
  [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "armv6l-linux"
    "armv7l-linux"
    "i686-linux"
    "mipsel-linux"
    "aarch64-darwin"
    "armv5tel-linux"
    "powerpc64le-linux"
    "riscv64-linux"
  ]);
    id = a: a;
    # :: (a -> string) -> (a -> b) -> [a] -> (b -> c) -> { string : c }
    genAttrsMapBy =
        # func to create name from set in sets
        by:
        # function to apply to all elements
        pf:
        # a list of to generate from
        sets:
        # another function to apply to all elements
        f:
        let
            fold = b: a: b // {
                ${by a} = f (pf a) ;
            };
        in  builtins.foldl' fold {} sets;

    eachSystem' = genAttrsMapBy id;
in ({
    inherit systems' eachSystem' id genAttrsMapBy;
})
