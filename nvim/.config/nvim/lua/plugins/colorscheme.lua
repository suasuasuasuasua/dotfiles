vim.pack.add 'https://github.com/folke/tokyonight.nvim'

require('tokyonight').setup {
  styles = {
    comments = { italic = false }, -- Disable italics in comments
  },
}
vim.cmd.colorscheme 'tokyonight-night'
