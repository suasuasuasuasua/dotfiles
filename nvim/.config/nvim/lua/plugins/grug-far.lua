vim.pack.add { 'https://github.com/MagicDuck/grug-far.nvim' }

require('grug-far').setup()

vim.keymap.set('n', '<leader>Fo', function() require('grug-far').open() end, { desc = '[F]ind and replace [O]pen' })
vim.keymap.set(
  { 'n', 'v' },
  '<leader>Fw',
  function() require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } } end,
  { desc = '[F]ind and replace current [W]ord' }
)
vim.keymap.set(
  { 'n', 'v' },
  '<leader>Ff',
  function() require('grug-far').open { prefills = { paths = vim.fn.expand '%' } } end,
  { desc = '[F]ind and replace in current [F]ile' }
)
