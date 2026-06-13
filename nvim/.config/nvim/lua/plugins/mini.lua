vim.pack.add {
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/rafamadriz/friendly-snippets',
}

require 'plugins.mini.ui'
require 'plugins.mini.editing'
require 'plugins.mini.clue'
require 'plugins.mini.completion'
require 'plugins.mini.git'
require 'plugins.mini.files'
require 'plugins.mini.pick'

require('mini.basics').setup()
