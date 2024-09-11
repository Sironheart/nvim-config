{inputs}: let
  inherit (inputs.nixpkgs) legacyPackages;
in rec {
  buildSironheartNvimPlugin = {system}: let
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

  mkNeovimPlugins = {system}: let
    inherit (pkgs) vimPlugins;
    pkgs = legacyPackages.${system};
    sironheart-nvim = buildSironheartNvimPlugin {inherit system;};
  in [
    # integrations
    vimPlugins.nvim-lspconfig
    vimPlugins.nvim-treesitter.withAllGrammars
    vimPlugins.vim-just
    vimPlugins.rustaceanvim
    vimPlugins.crates-nvim

    # telescope
    vimPlugins.plenary-nvim
    vimPlugins.telescope-nvim
    vimPlugins.telescope-ui-select-nvim

    # nvim dap
    vimPlugins.nvim-dap
    vimPlugins.nvim-dap-ui
    vimPlugins.nvim-nio
    vimPlugins.nvim-dap-virtual-text
    vimPlugins.nvim-dap-go

    # nvim cmp
    vimPlugins.cmp-buffer
    vimPlugins.cmp-nvim-lsp
    vimPlugins.cmp-path
    vimPlugins.cmp_luasnip
    vimPlugins.conform-nvim
    vimPlugins.friendly-snippets
    vimPlugins.lspkind-nvim
    vimPlugins.luasnip
    vimPlugins.nvim-cmp
    vimPlugins.nvim-ts-autotag

    # extras
    vimPlugins.auto-session
    vimPlugins.comment-nvim
    vimPlugins.copilot-lua
    vimPlugins.gitsigns-nvim
    vimPlugins.mini-nvim
    vimPlugins.nui-nvim
    vimPlugins.nvim-notify
    vimPlugins.nvim-treesitter-context
    vimPlugins.oil-nvim
    vimPlugins.trouble-nvim

    # basic plugins
    vimPlugins.oxocarbon-nvim
    vimPlugins.fidget-nvim
    vimPlugins.gitsigns-nvim
    vimPlugins.mkdir-nvim
    vimPlugins.noice-nvim
    vimPlugins.neodev-nvim
    vimPlugins.nvim-colorizer-lua
    vimPlugins.nvim-web-devicons
    vimPlugins.rainbow-delimiters-nvim
    vimPlugins.vim-sleuth
    vimPlugins.which-key-nvim

    # configuration
    sironheart-nvim
  ];

  mkExtraPackages = {system}: let
    inherit (pkgs) nodePackages;
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in [
    nodePackages."@astrojs/language-server"
    nodePackages."diagnostic-languageserver"
    nodePackages."dockerfile-language-server-nodejs"
    nodePackages."typescript-language-server"
    nodePackages."yaml-language-server"

    pkgs.cuelsp # Cue
    pkgs.emmet-ls # HTML/ CSS
    pkgs.gopls # Go
    pkgs.gotools # Go
    pkgs.java-language-server # Java
    pkgs.jsonnet-language-server # JSON
    pkgs.kotlin-language-server # Kotlin
    pkgs.lua-language-server # Lua
    pkgs.nil # Nix
    pkgs.nls # Nickel Lang
    pkgs.rust-analyzer-unwrapped # Rust
    pkgs.terraform-ls # HCL
    pkgs.vue-language-server

    # formatters
    nodePackages.prettier
    pkgs.alejandra # Nix
    pkgs.cue # Cue
    pkgs.eslint_d # JS
    pkgs.gofumpt # Go
    pkgs.golines # Go
    pkgs.jq # JSON
    pkgs.nickel # Nickel
    pkgs.nixpkgs-fmt # Nix
    pkgs.rustfmt # Rust
    pkgs.stylua # Lua
    pkgs.terraform # HCL

    # debug tools
    pkgs.delve # Go
  ];

  mkExtraConfig = ''
    lua << EOF
      require 'sironheart-nvim'
    EOF
  '';

  mkNeovim = {system}: let
    inherit (pkgs) lib neovim;
    extraPackages = mkExtraPackages {inherit system;};
    pkgs = legacyPackages.${system};
    start = mkNeovimPlugins {inherit system;};
  in
    neovim.override {
      configure = {
        customRC = mkExtraConfig;
        packages.main = {inherit start;};
      };
      extraMakeWrapperArgs = ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';
      withNodeJs = true;
      withPython3 = false;
      withRuby = false;
    };

  mkHomeManager = {system}: let
    extraConfig = mkExtraConfig;
    extraPackages = mkExtraPackages {inherit system;};
    plugins = mkNeovimPlugins {inherit system;};
  in {
    inherit extraConfig extraPackages plugins;

    enable = true;
    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
