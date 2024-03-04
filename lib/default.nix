{ inputs, ... }:
let
  inherit (inputs.nixpkgs) legacyPackages;
in
rec {
  buildSironheartNvimPlugin = { system }:
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
      sironheart-nvim = buildSironheartNvimPlugin { inherit system; };
      nightly = import ./plugins.nix;
    in
    [
      # integrations
      nightly.nvim-lspconfig
      vimPlugins.nvim-treesitter.withAllGrammars
      nightly.rustaceanvim
      vimPlugins.vim-just

      # telescope
      nightly.plenary-nvim
      nightly.telescope-nvim
      nightly.telescope-ui-select-nvim

      # nvim cmp
      nightly.cmp-buffer
      nightly.cmp-nvim-lsp
      nightly.cmp-path
      nightly.cmp_luasnip
      nightly.conform-nvim
      nightly.copilot-cmp
      nightly.copilot-lua
      nightly.friendly-snippets
      nightly.lspkind-nvim
      nightly.luasnip
      nightly.nvim-cmp
      nightly.nvim-ts-autotag

      # extras
      nightly.auto-session
      nightly.harpoon2
      nightly.mini-nvim
      nightly.nui-nvim
      nightly.nvim-treesitter-context
      nightly.oil-nvim
      nightly.trouble-nvim

      # basic plugins
      nightly.comment-nvim
      nightly.fidget-nvim
      nightly.gitsigns-nvim
      nightly.indent-blankline-nvim
      nightly.mkdir-nvim
      nightly.neodev-nvim
      nightly.nvim-colorizer-lua
      nightly.nvim-web-devicons
      nightly.rainbow-delimiters-nvim
      nightly.vim-sleuth
      nightly.which-key-nvim
      nightly.flexoki

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
      pkgs.elixir-ls
      pkgs.gopls
      pkgs.java-language-server
      pkgs.jsonnet-language-server
      pkgs.kotlin-language-server
      pkgs.ktlint
      pkgs.lua-language-server
      pkgs.nil
      pkgs.rust-analyzer
      pkgs.terraform-ls
      pkgs.zls

      # formatters
      pkgs.biome
      pkgs.eslint_d
      pkgs.gofumpt
      pkgs.golines
      pkgs.nixpkgs-fmt
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
