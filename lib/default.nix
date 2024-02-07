{ inputs }:

let
  inherit (inputs.nixpkgs) legacyPackages;
in
rec {
  mkVimPlugin = { system }:
    let
      inherit (pkgs) vimUtils;
      inherit (vimUtils) buildVimPlugin;
      pkgs = legacyPackages.${system};
    in
    buildVimPlugin {
      name = "sironheart-nvim";
      postInstall = ''
        rm -rf $out/.editorconfig
        rm -rf $out/README.md
        rm -rf $out/flake.lock
        rm -rf $out/flake.nix
        rm -rf $out/lib
      '';
      src = ../.;
    };

  mkNeovimPlugins = { system }:
    let
      inherit (pkgs) vimPlugins;
      pkgs = legacyPackages.${system};
      sironheart-nvim = mkVimPlugin { inherit system; };
    in
    [
      # integrations
      vimPlugins.nvim-lspconfig
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.rust-tools-nvim
      vimPlugins.vim-just
      vimPlugins.none-ls-nvim

      # telescope
      vimPlugins.plenary-nvim
      vimPlugins.telescope-nvim

      # nvim cmp
      vimPlugins.nvim-cmp
      vimPlugins.luasnip
      vimPlugins.cmp_luasnip
      vimPlugins.cmp-nvim-lsp
      vimPlugins.cmp-buffer
      vimPlugins.cmp-path
      vimPlugins.friendly-snippets
      vimPlugins.nvim-autopairs
      vimPlugins.nvim-ts-autotag
      vimPlugins.lspkind-nvim
      vimPlugins.none-ls-nvim

      # extras
      vimPlugins.gitsigns-nvim
      vimPlugins.lualine-nvim
      vimPlugins.neo-tree-nvim
      vimPlugins.nui-nvim
      vimPlugins.nvim-treesitter-context
      vimPlugins.trouble-nvim

      # basic plugins
      vimPlugins.comment-nvim
      vimPlugins.dressing-nvim
      vimPlugins.gitsigns-nvim
      vimPlugins.indent-blankline-nvim
      vimPlugins.mkdir-nvim
      vimPlugins.nvim-colorizer-lua
      vimPlugins.nvim-web-devicons
      vimPlugins.rainbow-delimiters-nvim
      vimPlugins.vim-fugitive
      vimPlugins.vim-rhubarb
      vimPlugins.vim-sleuth
      vimPlugins.which-key-nvim
      vimPlugins.neodev-nvim

      # configuration
      sironheart-nvim
    ];

  mkExtraPackages = { system }:
    let
      inherit (pkgs) nodePackages;
      pkgs = (import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    in
    [
      nodePackages."bash-language-server"
      nodePackages."diagnostic-languageserver"
      nodePackages."dockerfile-language-server-nodejs"
      nodePackages."typescript"
      nodePackages."typescript-language-server"
      nodePackages."vscode-langservers-extracted"
      nodePackages."yaml-language-server"

      pkgs.cuelsp
      pkgs.gopls
      pkgs.java-language-server
      pkgs.jsonnet-language-server
      pkgs.kotlin-language-server
      pkgs.lua-language-server
      pkgs.nil
      pkgs.rust-analyzer
      pkgs.terraform-ls

      # formatters
      nodePackages.prettier
      pkgs.eslint_d
      pkgs.nixpkgs-fmt
      pkgs.gofumpt
      pkgs.golines
      pkgs.rustfmt
      pkgs.stylua
      pkgs.terraform
    ];

  mkExtraConfig = ''
    lua << EOF
      require 'sironheart-nvim'
    EOF
  '';

  mkNeovim = { system }:
    let
      inherit (pkgs) lib neovim;
      extraPackages = mkExtraPackages { inherit system; };
      pkgs = legacyPackages.${system};
      start = mkNeovimPlugins { inherit system; };
    in
    neovim.override {
      configure = {
        customRC = mkExtraConfig;
        packages.main = { inherit start; };
      };
      extraMakeWrapperArgs = ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
    };

  mkHomeManager = { system }:
    let
      extraConfig = mkExtraConfig;
      extraPackages = mkExtraPackages { inherit system; };
      plugins = mkNeovimPlugins { inherit system; };
    in
    {
      inherit extraConfig extraPackages plugins;
      enable = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
    };
}