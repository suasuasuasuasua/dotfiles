vim.pack.add { 'https://github.com/tpope/vim-fugitive' }

vim.keymap.set('n', '<leader>lg', '<Cmd>tab Git<CR>', { desc = 'Open fugitive' })
