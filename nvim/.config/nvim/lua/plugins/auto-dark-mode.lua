vim.pack.add { 'https://github.com/f-person/auto-dark-mode.nvim' }

require('auto-dark-mode').setup {
  update_interval = 1000,
  set_dark_mode = function()
    vim.o.background = 'dark'
    if vim.g.colors_name then vim.cmd.colorscheme(vim.g.colors_name) end
  end,
  set_light_mode = function()
    vim.o.background = 'light'
    if vim.g.colors_name then vim.cmd.colorscheme(vim.g.colors_name) end
  end,
}
