vim.pack.add { 'https://github.com/nvim-tree/nvim-tree.lua' }

require('nvim-tree').setup {
  renderer = {
    icons = {
      web_devicons = {
        file = { enable = true, color = true },
        folder = { enable = false, color = true },
      },
    },
  },
}

-- vim.keymap.set('n', '<leader>e', '<Cmd>NvimTreeToggle<CR>', { desc = 'Toggle file [E]xplorer' })
-- vim.keymap.set('n', '<leader>E', '<Cmd>NvimTreeFindFile<CR>', { desc = 'Reveal file in [E]xplorer' })
