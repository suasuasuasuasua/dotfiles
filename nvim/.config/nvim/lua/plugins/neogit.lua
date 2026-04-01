vim.pack.add {
  'https://github.com/NeogitOrg/neogit',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/sindrets/diffview.nvim',
}

vim.keymap.set('n', '<Leader>gg', '<CMD>Neogit<CR>', { desc = 'Show Neogit UI' })
