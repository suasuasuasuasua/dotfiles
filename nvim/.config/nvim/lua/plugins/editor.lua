vim.pack.add {
  'https://github.com/NMAC427/guess-indent.nvim',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/kylechui/nvim-surround',
}

require('guess-indent').setup {}
require('nvim-autopairs').setup {}
require('nvim-surround').setup {}
