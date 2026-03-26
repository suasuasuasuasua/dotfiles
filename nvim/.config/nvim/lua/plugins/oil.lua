vim.pack.add { 'https://github.com/stevearc/oil.nvim' }

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

require('oil').setup {
  keymaps = {
    ['<C-l>'] = 'actions.select',
    ['<C-h>'] = { 'actions.parent', mode = 'n' },
    ['<C-x>'] = { 'actions.select', opts = { horizontal = true } },
    ['<C-s>'] = false,
    ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
    ['<C-r>'] = { 'actions.refresh' },
    ['y.'] = { 'actions.copy_entry_path' },
    ['<C-d>'] = { 'actions.preview_scroll_down' },
    ['<C-u>'] = { 'actions.preview_scroll_up' },
  },
}
