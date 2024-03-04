{ inputs }:
let
  inherit (inputs.nixpkgs) pkgs vimUtils;
  inherit (vimUtils) buildVimPlugin;
in
{
  nvim-lspconfig = buildVimPlugin rec {
    name = "nvim-lspconfig";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "neovim";
      repo = "nvim-lspconfig";
      sha256 = null;
    };
  };
  rustaceanvim = buildVimPlugin rec {
    name = "rustaceanvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "mrcjkb";
      repo = "rustaceanvim";
      sha256 = null;
    };
  };
  plenary-nvim = buildVimPlugin rec {
    name = "plenary.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "nvim-lua";
      repo = "plenary.nvim";
      sha256 = null;
    };
  };
  telescope-nvim = buildVimPlugin rec {
    name = "telescope.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "nvim-lua";
      repo = "telescope.nvim";
      sha256 = null;
    };
  };
  telescope-ui-select-nvim = buildVimPlugin rec {
    name = "telescope-ui-select.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "nvim-lua";
      repo = "telescope-ui-select.nvim";
      sha256 = null;
    };
  };
  cmp-buffer = buildVimPlugin rec {
    name = "cmp-buffer";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "hrsh7th";
      repo = "cmp-buffer";
      sha256 = null;
    };
  };
  cmp-nvim-lsp = buildVimPlugin rec {
    name = "cmp-nvim-lsp";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "hrsh7th";
      repo = "cmp-nvim-lsp";
      sha256 = null;
    };
  };
  cmp-path = buildVimPlugin rec {
    name = "cmp-path";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "hrsh7th";
      repo = "cmp-path";
      sha256 = null;
    };
  };
  cmp-luasnip = buildVimPlugin rec {
    name = "cmp-luasnip";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "saadparwaiz1";
      repo = "cmp_luasnip";
      sha256 = null;
    };
  };
  conform-nvim = buildVimPlugin rec {
    name = "conform.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "tjdevries";
      repo = "conform.nvim";
      sha256 = null;
    };
  };
  friendly-snippets = buildVimPlugin rec {
    name = "friendly-snippets";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "rafamadriz";
      repo = "friendly-snippets";
      sha256 = null;
    };
  };
  lspkind-nvim = buildVimPlugin rec {
    name = "lspkind-nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "onsails";
      repo = "lspkind-nvim";
      sha256 = null;
    };
  };
  luasnip = buildVimPlugin rec {
    name = "luasnip";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "L3MON4D3";
      repo = "luasnip";
      sha256 = null;
    };
  };
  nvim-cmp = buildVimPlugin rec {
    name = "nvim-cmp";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "hrsh7th";
      repo = "nvim-cmp";
      sha256 = null;
    };
  };
  nvim-ts-autotag = buildVimPlugin rec {
    name = "nvim-ts-autotag";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "windwp";
      repo = "nvim-ts-autotag";
      sha256 = null;
    };
  };
  gitsigns-nvim = buildVimPlugin rec {
    name = "gitsigns.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "lewis6991";
      repo = "gitsigns.nvim";
      sha256 = null;
    };
  };
  harpoon-nvim = buildVimPlugin rec {
    name = "harpoon";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "ThePrimeagen";
      repo = "harpoon";
      rev = "harpoon2";
      sha256 = null;
    };
  };
  mini-nvim = buildVimPlugin rec {
    name = "mini.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "wakatime";
      repo = "mini.nvim";
      sha256 = null;
    };
  };
  nui-nvim = buildVimPlugin rec {
    name = "nui.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "MunifTanjim";
      repo = "nui.nvim";
      sha256 = null;
    };
  };
  nvim-treesitter-context = buildVimPlugin rec {
    name = "nvim-treesitter-context";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "romgrk";
      repo = "nvim-treesitter-context";
      sha256 = null;
    };
  };
  oil-nvim = buildVimPlugin rec {
    name = "oil.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "stevearc";
      repo = "oil.nvim";
      sha256 = null;
    };
  };
  trouble-nvim = buildVimPlugin rec {
    name = "trouble.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "folke";
      repo = "trouble.nvim";
      sha256 = null;
    };
  };
  comment-nvim = buildVimPlugin rec {
    name = "comment.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "numToStr";
      repo = "comment.nvim";
      sha256 = null;
    };
  };
  fidget-nvim = buildVimPlugin rec {
    name = "fidget.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "numToStr";
      repo = "fidget.nvim";
      sha256 = null;
    };
  };
  indent-blankline-nvim = buildVimPlugin rec {
    name = "indent-blankline.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "lukas-reineke";
      repo = "indent-blankline.nvim";
      sha256 = null;
    };
  };
  mkdir-nvim = buildVimPlugin rec {
    name = "mkdir.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "numToStr";
      repo = "mkdir.nvim";
      sha256 = null;
    };
  };
  neodev-nvim = buildVimPlugin rec {
    name = "neodev.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "numToStr";
      repo = "neodev.nvim";
      sha256 = null;
    };
  };
  nvim-colorizer-lua = buildVimPlugin rec {
    name = "nvim-colorizer.lua";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "norcalli";
      repo = "nvim-colorizer.lua";
      sha256 = null;
    };
  };
  nvim-web-devicons = buildVimPlugin rec {
    name = "nvim-web-devicons";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "kyazdani42";
      repo = "nvim-web-devicons";
      sha256 = null;
    };
  };
  rainbow-delimiters-nvim = buildVimPlugin rec {
    name = "rainbow-delimiters.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "numToStr";
      repo = "rainbow-delimiters.nvim";
      sha256 = null;
    };
  };
  vim-sleuth = buildVimPlugin rec {
    name = "vim-sleuth";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "tpope";
      repo = "vim-sleuth";
      sha256 = null;
    };
  };
  which-key-nvim = buildVimPlugin rec {
    name = "which-key.nvim";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "folke";
      repo = "which-key.nvim";
      sha256 = null;
    };
  };
  flexoki = buildVimPlugin rec {
    name = "flexoki";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "kepano";
      repo = "flexoki-neovim";
      sha256 = null;
    };
  };
  vim-just = buildVimPlugin rec {
    name = "vim-just";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "NoahTheDuke";
      repo = "vim-just";
      sha256 = null;
    };
  };
  copilot-lua = buildVimPlugin rec {
    name = "copilot-lua";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "zbirenbaum";
      repo = "copilot.lua";
      sha256 = null;
    };
  };
  copilot-cmp = buildVimPlugin rec {
    name = "copilot-cmp";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "zbirenbaum";
      repo = "copilot-cmp";
      sha256 = null;
    };
  };
  auto-session-nvim = buildVimPlugin rec {
    name = "auto-session";
    src = pkgs.fetchFromGitHub {
      name = name;
      owner = "rmagatti";
      repo = "auto-session";
      sha256 = null;
    };
  };
}
