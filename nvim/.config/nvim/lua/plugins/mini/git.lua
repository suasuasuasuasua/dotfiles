local diff = require 'mini.diff'
diff.setup {
  view = {
    style = 'sign',
    signs = { add = '+', change = '~', delete = '_' },
  },
}

vim.keymap.set('n', ']c', function()
  if vim.wo.diff then
    vim.cmd.normal { ']c', bang = true }
  else
    diff.goto_hunk 'next'
  end
end, { desc = 'Jump to next git [c]hange' })
vim.keymap.set('n', '[c', function()
  if vim.wo.diff then
    vim.cmd.normal { '[c', bang = true }
  else
    diff.goto_hunk 'prev'
  end
end, { desc = 'Jump to previous git [c]hange' })
vim.keymap.set({ 'n', 'v' }, '<leader>hr', 'gH', { remap = true, desc = 'git [r]eset hunk' })
vim.keymap.set('n', '<leader>hp', diff.toggle_overlay, { desc = 'git [p]review hunk (overlay)' })
vim.keymap.set('n', '<leader>tD', diff.toggle_overlay, { desc = '[T]oggle git [D]iff overlay' })

require('mini.git').setup()
vim.keymap.set({ 'n', 'x' }, '<leader>hb', function() MiniGit.show_at_cursor() end,
  { desc = 'git [b]lame line / show at cursor' })
vim.keymap.set('n', '<leader>hd', '<cmd>Git diff --cached -- %<CR>', { desc = 'git [d]iff against index' })
vim.keymap.set('n', '<leader>hD', '<cmd>Git diff HEAD -- %<CR>', { desc = 'git [D]iff against last commit' })
