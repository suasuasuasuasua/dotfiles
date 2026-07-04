local diff = require 'mini.diff'
diff.setup {
  view = {
    style = 'sign',
    signs = { add = '+', change = '~', delete = '_' },
  },
}

vim.keymap.set('n', '<leader>hp', diff.toggle_overlay, { desc = 'git [p]review hunk (overlay)' })

require('mini.git').setup()

vim.keymap.set('n', '<leader>hb', '<cmd>Git blame<CR>', { desc = 'git [b]lame' })
vim.keymap.set('n', '<leader>hd', '<cmd>Git diff --cached -- %<CR>', { desc = 'git [d]iff against index' })
vim.keymap.set('n', '<leader>hD', '<cmd>Git diff HEAD -- %<CR>', { desc = 'git [D]iff against last commit' })
vim.keymap.set({ 'n', 'x' }, '<Leader>hs', '<cmd>lua MiniGit.show_at_cursor()<CR>', { desc = 'Show at cursor' })
