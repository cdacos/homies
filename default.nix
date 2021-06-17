# The main homies file, where homies are defined. See the README.md for
# instructions.
let
  pkgs = import ./nix {};

  # The list of packages to be installed
  homies = with pkgs;
    [
      # Customized packages
      bashrc
      git
      python
      tmux
      vim

      pkgs.curl
      pkgs.direnv
      pkgs.gnupg
      pkgs.htop
      pkgs.less
      pkgs.niv
      pkgs.nix
      pkgs.wol

      # 'Modern' Unix commands
      # https://github.com/ibraheemdev/modern-unix
      pkgs.bat # bat (cat)
      pkgs.du-dust # dust (du)
      pkgs.exa # exa (ls)
      pkgs.fzf # fzf (fuzzy finder)
      pkgs.fd # fd (find)
      pkgs.sd # sd (sed)
      pkgs.ripgrep # rg (grep / ag)
      pkgs.jq # jq (json)
      pkgs.broot # br (tree file nav)
      pkgs.tealdeer # tldr
      pkgs.hyperfine # hyperfine (command line benchmarking)
      pkgs.bottom # btm (top / htop)
      pkgs.procs # procs (ps)
      pkgs.xh # xh (httpie clone)
    ];

  ## Some customizations
  python = pkgs.python.withPackages (ps: [ ps.grip ]);

  # A custom '.bashrc' (see bashrc/default.nix for details)
  bashrc = pkgs.callPackage ./bashrc {};

  # Git with config baked in
  git = import ./git (
    { inherit (pkgs) sources runCommand makeWrapper symlinkJoin writeTextFile;
      git = pkgs.git;
    });

  # Tmux with a custom tmux.conf baked in
  tmux = import ./tmux (with pkgs;
    { inherit
        makeWrapper
        symlinkJoin
        writeText;
      tmux = pkgs.tmux;
    });

  # Vim with a custom vimrc and set of packages
  vim = pkgs.callPackage ./vim
    { inherit
        git
        tmux;
    };

in
  if pkgs.lib.inNixShell
  then pkgs.mkShell
    { buildInputs = homies;
      shellHook = ''
        $(bashrc)
        '';
    }
  else homies
