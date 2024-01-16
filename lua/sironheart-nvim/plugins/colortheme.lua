return {
  {
    'kepano/flexoki-neovim',
    config = function()
      require('flexoki')
      vim.cmd('colorscheme flexoki-dark')
    end
  },
}
