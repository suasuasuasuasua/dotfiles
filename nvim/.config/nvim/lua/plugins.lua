vim.pack.add {
  'https://github.com/MagicDuck/grug-far.nvim',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/NMAC427/guess-indent.nvim',
  'https://github.com/NeogitOrg/neogit',
  'https://github.com/alexghergh/nvim-tmux-navigation',
  'https://github.com/danymat/neogen',
  'https://github.com/direnv/direnv.vim',
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/folke/tokyonight.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/kevinhwang91/nvim-ufo',
  'https://github.com/kevinhwang91/promise-async',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/stevearc/conform.nvim',
  {
    src = 'https://github.com/L3MON4D3/LuaSnip',
    version = vim.version.range '2.0.0 - 3.0.0',
  },
  {
    src = 'https://github.com/Saghen/blink.cmp',
    version = vim.version.range '1.0.0 - 2.0.0',
  },
}

require('ufo').setup {
  provider_selector = function(bufnr, filetype, buftype) return { 'treesitter', 'indent' } end,
}

require('nvim-tmux-navigation').setup {
  disable_when_zoomed = true, -- defaults to false
  keybindings = {
    left = '<C-h>',
    down = '<C-j>',
    up = '<C-k>',
    right = '<C-l>',
    last_active = '<C-\\>',
    next = '<C-Space>',
  },
}

require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Jump to next git [c]hange' })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Jump to previous git [c]hange' })

    -- Actions
    -- visual mode
    map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
      { desc = 'git [s]tage hunk' })
    map('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
      { desc = 'git [r]eset hunk' })
    -- normal mode
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
    map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
    map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
    map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
    map('n', '<leader>hD', function() gitsigns.diffthis '@' end, { desc = 'git [D]iff against last commit' })
    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
    map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
  end,
}

require('guess-indent').setup {}

require('blink.cmp').setup {
  keymap = {
    -- All presets have the following mappings:
    -- <tab>/<s-tab>: move to right/left of your snippet expansion
    -- <c-space>: Open menu or open docs if already open
    -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
    -- <c-e>: Hide menu
    -- <c-k>: Toggle signature help
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    preset = 'default',
  },
  appearance = { nerd_font_variant = 'mono' },
  completion = { documentation = { auto_show = false, auto_show_delay_ms = 500 } },
  sources = { default = { 'lsp', 'path', 'snippets' } },
  snippets = { preset = 'luasnip' },

  -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
  -- which automatically downloads a prebuilt binary when enabled.
  --
  -- By default, we use the Lua implementation instead, but you may enable
  -- the rust implementation via `'prefer_rust_with_warning'`
  --
  -- See :h blink-cmp-config-fuzzy for more information
  fuzzy = { implementation = 'lua' },

  -- Shows a signature help window while you type arguments for a function
  signature = { enabled = true },
}

require('luasnip').setup()
require('luasnip.loaders.from_vscode').lazy_load()

require('tokyonight').setup {
  styles = {
    comments = { italic = false }, -- Disable italics in comments
  },
}
vim.cmd.colorscheme 'tokyonight-night'

require('todo-comments').setup {
  signs = false,
}

local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
require('nvim-treesitter').install(parsers)
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end

    -- check if parser exists and load it
    if not vim.treesitter.language.add(language) then return end
    -- enables syntax highlighting and other treesitter features
    vim.treesitter.start(buf, language)

    -- enables treesitter based folds
    -- for more info on folds see `:help folds`
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldmethod = 'expr'

    -- enables treesitter based indentation
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.keymap.set('', '<leader>f', function() require('conform').format { async = true, lsp_format = 'fallback' } end,
  { desc = '[F]ormat buffer' })
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Disable "format_on_save lsp_fallback" for languages that don't
    -- have a well standardized coding style. You can add additional
    -- languages here or re-enable it for the disabled ones.
    local disable_filetypes = { c = true, cpp = true }
    if disable_filetypes[vim.bo[bufnr].filetype] then
      return nil
    else
      return {
        timeout_ms = 500,
        lsp_format = 'fallback',
      }
    end
  end,
  formatters_by_ft = {
    lua = { 'stylua' },
    -- Conform can also run multiple formatters sequentially
    -- python = { "isort", "black" },
    --
    -- You can use 'stop_after_first' to run the first available formatter from the list
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
}

require('fidget').setup()
require('mason').setup()
require('neogen').setup()

-- mini ecosystem setup
-- https://nvim-mini.org/mini.nvim/
require('mini.ai').setup()
local miniclue = require('mini.clue')
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
require('mini.files').setup {
  -- prevents bug with git difftool -d with nvim.difftool
  options = { use_as_default_explorer = false, },
}
local indentscope = require('mini.indentscope')
indentscope.setup {
  draw = {
    delay = 10,
    animation = indentscope.gen_animation.none(),
  },
}
require('mini.icons').setup()
require('mini.pairs').setup()
local pick = require('mini.pick')
require('mini.extra').setup()
pick.setup()
--
-- Adding custom picker to pick `register` entries
pick.registry.registry = function()
  local items = vim.tbl_keys(pick.registry)
  table.sort(items)
  local source = { items = items, name = 'Registry', choose = function() end }
  local chosen_picker_name = pick.start({ source = source })
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

-- https://nvim-mini.org/mini.nvim/doc/mini-extra.html#miniextra.pickers.lsp
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('minipick-lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf
    -- Find references for the word under your cursor.
    vim.keymap.set('n', 'grr', function() builtin.lsp { scope = 'references' } end,
      { buffer = buf, desc = '[G]oto [R]eferences' })
    -- Jump to the implementation of the word under your cursor.
    -- Useful when your language has ways of declaring types without an actual implementation.
    vim.keymap.set('n', 'gri', function() builtin.lsp { scope = 'implementation' } end,
      { buffer = buf, desc = '[G]oto [I]mplementation' })
    -- Jump to the definition of the word under your cursor.
    -- This is where a variable was first declared, or where a function is defined, etc.
    -- To jump back, press <C-t>.
    vim.keymap.set('n', 'grd', function() builtin.lsp { scope = 'definition' } end,
      { buffer = buf, desc = '[G]oto [D]efinition' })
    -- Fuzzy find all the symbols in your current document.
    -- Symbols are things like variables, functions, types, etc.
    vim.keymap.set('n', 'gO', function() builtin.lsp { scope = 'document_symbol' } end,
      { buffer = buf, desc = 'Open Document Symbols' })
    -- Fuzzy find all the symbols in your current workspace.
    -- Similar to document symbols, except searches over your entire project.
    vim.keymap.set('n', 'gW', function() builtin.lsp { scope = 'workspace_symbol' } end,
      { buffer = buf, desc = 'Open Workspace Symbols' })
    -- Jump to the type of the word under your cursor.
    -- Useful when you're not sure what type a variable is and you want to see
    -- the definition of its *type*, not where it was *defined*.
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
require('mini.statusline').setup()

-- builtins
vim.cmd('packadd nvim.difftool')
vim.cmd('packadd nvim.undotree')
