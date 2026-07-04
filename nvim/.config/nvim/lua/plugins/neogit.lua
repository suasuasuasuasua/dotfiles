vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/NeogitOrg/neogit',
}

require('neogit').setup {}

vim.keymap.set('n', '<leader>lg', '<Cmd>Neogit<Cr>', { desc = 'Toggle Neogit' })
