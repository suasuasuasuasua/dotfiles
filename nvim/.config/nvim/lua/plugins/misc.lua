-- Library plugins and standalone tools
vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/direnv/direnv.vim',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/danymat/neogen',
}

require('mason').setup()
require('neogen').setup()
