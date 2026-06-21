require('mini.ai').setup()
require('mini.bracketed').setup()
require('mini.jump').setup {
  delay = { highlight = 10 },
}
require('mini.move').setup()
require('mini.pairs').setup {
  modes = { command = true },
}
require('mini.splitjoin').setup()
require('mini.trailspace').setup()

require('mini.misc').setup()
MiniMisc.setup_auto_root()

require('mini.surround').setup {
  -- https://nvim-mini.org/mini.nvim/doc/mini-surround.html#minisurround.config-setupsimilartotpopevim-surround
  mappings = {
    add = 'ys', -- Add surrounding in Normal and Visual modes
    delete = 'ds', -- Delete surrounding
    find = '', -- Find surrounding (to the right)
    find_left = '', -- Find surrounding (to the left)
    highlight = '', -- Highlight surrounding
    replace = 'cs', -- Replace surrounding

    suffix_last = '', -- Suffix to search with "prev" method
    suffix_next = '', -- Suffix to search with "next" method
  },
  search_method = 'cover_or_next',
}
-- Remap adding surrounding to Visual mode selection
vim.keymap.del('x', 'ys')
vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
-- Make special mapping for "add surrounding for line"
vim.keymap.set('n', 'yss', 'ys_', { remap = true })

local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup {
  snippets = {
    gen_loader.from_lang(),
  },
}
