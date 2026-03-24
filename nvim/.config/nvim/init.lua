vim.g.have_nerd_font = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.autoindent = true
vim.o.breakindent = true
vim.o.colorcolumn = "80"
vim.o.confirm = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.foldcolumn = '1'
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.ignorecase = true
vim.o.inccommand = 'split'
vim.o.list = true
vim.o.mouse = 'a'
vim.o.number = true
vim.o.scrolloff = 10
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.o.showmode = false
vim.o.signcolumn = 'yes'
vim.o.smartcase = true
vim.o.softtabstop = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.timeoutlen = 300
vim.o.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.o.undofile = true
vim.o.updatetime = 250
vim.o.wrap = false

vim.opt.completeopt = { "menuone", "popup", "noinsert" }
vim.opt.listchars = { tab = '> ', trail = '-', nbsp = '+' }

require 'autocmd'
require 'keymaps'
require 'lsp'
require 'plugins'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
