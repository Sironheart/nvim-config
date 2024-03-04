{ inputs }:

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

  buildFlexOkiNvimPlugin = { system }:
    let
      inherit (pkgs) vimUtils;
      inherit (vimUtils) buildVimPlugin;
      pkgs = legacyPackages.${system};
    in
    buildVimPlugin
      {
        name = "flexoki-neovim";
        postInstall = ''
          rm -rf $out/screenshots
          rm -rf $out/LICENSE
          rm -rf $out/README.md
        '';
        src = inputs.flexoki;
      };

  mkNeovimPlugins = { system }:
    let
      inherit (pkgs) vimPlugins;
      flexoki = buildFlexOkiNvimPlugin { inherit system; };
      pkgs = legacyPackages.${system};
      sironheart-nvim = buildSironheartNvimPlugin { inherit system; };
    in
    [
      # integrations
      vimPlugins.nvim-lspconfig
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.rustaceanvim
      vimPlugins.vim-just

      # telescope
      vimPlugins.plenary-nvim
      vimPlugins.telescope-nvim
      vimPlugins.telescope-ui-select-nvim

      # nvim cmp
      vimPlugins.cmp-buffer
      vimPlugins.cmp-nvim-lsp
      vimPlugins.cmp-path
      vimPlugins.cmp_luasnip
      vimPlugins.conform-nvim
      vimPlugins.copilot-cmp
      vimPlugins.copilot-lua
      vimPlugins.friendly-snippets
      vimPlugins.lspkind-nvim
      vimPlugins.luasnip
      vimPlugins.nvim-cmp
      vimPlugins.nvim-ts-autotag

      # extras
      vimPlugins.auto-session
      vimPlugins.gitsigns-nvim
      vimPlugins.harpoon2
      vimPlugins.mini-nvim
      vimPlugins.nui-nvim
      vimPlugins.nvim-treesitter-context
      vimPlugins.oil-nvim
      vimPlugins.trouble-nvim

      # basic plugins
      vimPlugins.comment-nvim
      vimPlugins.fidget-nvim
      vimPlugins.gitsigns-nvim
      vimPlugins.indent-blankline-nvim
      vimPlugins.mkdir-nvim
      vimPlugins.neodev-nvim
      vimPlugins.nvim-colorizer-lua
      vimPlugins.nvim-web-devicons
      vimPlugins.rainbow-delimiters-nvim
      vimPlugins.vim-sleuth
      vimPlugins.which-key-nvim

      # configuration
      flexoki
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
