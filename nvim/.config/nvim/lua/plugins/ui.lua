vim.pack.add {
  'https://github.com/folke/which-key.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/kevinhwang91/promise-async',
  'https://github.com/kevinhwang91/nvim-ufo',
  'https://github.com/folke/todo-comments.nvim',
}

require('which-key').setup {
  -- delay between pressing a key and opening which-key (milliseconds)
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },

  -- Document existing key chains
  spec = {
    { '<leader>s', group = '[S]earch',    mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk',  mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
    { 'gr',        group = 'LSP Actions', mode = { 'n' } },
  },
}

require('fidget').setup()
require('lualine').setup()
require('ibl').setup()
require('render-markdown').setup()

require('ufo').setup {
  provider_selector = function(bufnr, filetype, buftype) return { 'treesitter', 'indent' } end,
}

require('todo-comments').setup {
  signs = false,
}
