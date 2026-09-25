{ pkgs, multiverse, ... }:

{
  # env.GREET = "hello";

  languages.odin.enable = true;

  packages = [
    # pkgs.odin
    multiverse.odin."dev-2026-09"
  ];

  scripts.prun.exec = ''
    odin run src
  '';
  scripts.prund.exec = ''
    odin run src -debug
  '';
}
