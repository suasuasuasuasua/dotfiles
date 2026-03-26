vim.pack.add {
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/rafamadriz/friendly-snippets',
}

require('mini.ai').setup()
local miniclue = require 'mini.clue'
miniclue.setup {
  triggers = {
    -- Leader triggers
    { mode = { 'n', 'x' }, keys = '<Leader>' },
    -- `[` and `]` keys
    { mode = 'n',          keys = '[' },
    { mode = 'n',          keys = ']' },
    -- Built-in completion
    { mode = 'i',          keys = '<C-x>' },
    -- `g` key
    { mode = { 'n', 'x' }, keys = 'g' },
    -- Marks
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },
    -- Registers
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },
    -- Window commands
    { mode = 'n',          keys = '<C-w>' },
    -- `z` key
    { mode = { 'n', 'x' }, keys = 'z' },
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },

  window = {
    -- Delay before showing clue window
    delay = 10,

    -- Keys to scroll inside the clue window
    scroll_down = '<C-d>',
    scroll_up = '<C-u>',
  },
}
require('mini.cmdline').setup()
require('mini.completion').setup {
  delay = { completion = 10, info = 10, signature = 5 },
}
-- NOTE: oil is more ergonomic
-- require('mini.files').setup {
--   -- prevents bug with git difftool -d with nvim.difftool
--   options = { use_as_default_explorer = false },
-- }
local indentscope = require 'mini.indentscope'
indentscope.setup {
  draw = {
    delay = 10,
    animation = indentscope.gen_animation.none(),
  },
}
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()
MiniIcons.tweak_lsp_kind()
require('mini.notify').setup()
require('mini.pairs').setup {
  modes = { command = true }
}
local pick = require 'mini.pick'
require('mini.extra').setup()
pick.setup()
--
-- Adding custom picker to pick `register` entries
pick.registry.registry = function()
  local items = vim.tbl_keys(pick.registry)
  table.sort(items)
  local source = { items = items, name = 'Registry', choose = function() end }
  local chosen_picker_name = pick.start { source = source }
  if chosen_picker_name == nil then return end
  return pick.registry[chosen_picker_name]()
end
--
-- Make `:Pick files` accept `cwd`
pick.registry.files = function(local_opts)
  local opts = { source = { cwd = local_opts.cwd } }
  local_opts.cwd = nil
  return pick.builtin.files(local_opts, opts)
end

local builtin = pick.registry
vim.keymap.set('n', '<leader>sh', builtin.help, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', function() builtin.files { cwd = vim.fn.getcwd() } end,
  { desc = '[S]earch [N]eovim files' })
vim.keymap.set('n', '<leader>ss', builtin.registry, { desc = '[S]earch [S]elect Registry' })
vim.keymap.set('n', '<leader>sg', builtin.grep_live, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostic, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>sn', function() builtin.files { cwd = vim.fn.stdpath 'config' } end,
  { desc = '[S]earch [N]eovim files' })
vim.keymap.set('n', '<leader>s:', function() builtin.history { scope = ':' } end, { desc = '[S]earch [N]eovim commands' })
vim.keymap.set('n', '<leader>s/', function() builtin.history { scope = '/' } end, { desc = '[S]earch [N]eovim search' })

-- https://nvim-mini.org/mini.nvim/doc/mini-extra.html#miniextra.pickers.lsp
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('minipick-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf
    vim.keymap.set('n', 'grr', function() builtin.lsp { scope = 'references' } end,
      { buffer = buf, desc = '[G]oto [R]eferences' })
    vim.keymap.set('n', 'gri', function() builtin.lsp { scope = 'implementation' } end,
      { buffer = buf, desc = '[G]oto [I]mplementation' })
    vim.keymap.set('n', 'grd', function() builtin.lsp { scope = 'definition' } end,
      { buffer = buf, desc = '[G]oto [D]efinition' })
    vim.keymap.set('n', 'gO', function() builtin.lsp { scope = 'document_symbol' } end,
      { buffer = buf, desc = 'Open Document Symbols' })
    vim.keymap.set('n', 'gW', function() builtin.lsp { scope = 'workspace_symbol' } end,
      { buffer = buf, desc = 'Open Workspace Symbols' })
    vim.keymap.set('n', 'grt', function() builtin.lsp { scope = 'type_definition' } end,
      { buffer = buf, desc = '[G]oto [T]ype Definition' })
  end,
})

require('mini.surround').setup {
  -- https://nvim-mini.org/mini.nvim/doc/mini-surround.html#minisurround.config-setupsimilartotpopevim-surround
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    add = 'ys',       -- Add surrounding in Normal and Visual modes
    delete = 'ds',    -- Delete surrounding
    find = '',        -- Find surrounding (to the right)
    find_left = '',   -- Find surrounding (to the left)
    highlight = '',   -- Highlight surrounding
    replace = 'cs',   -- Replace surrounding

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

vim.keymap.set('n', '-', [[:<C-u>lua MiniFiles.open()<CR>]], { desc = 'Open parent directory' })

require('mini.trailspace').setup()
local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup {
  snippets = {
    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
}
MiniSnippets.start_lsp_server()
require('mini.statusline').setup()
