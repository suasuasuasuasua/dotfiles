local program_name = "direnv"
if vim.fn.executable(program_name) == 0 then
  return
end

vim.pack.add { 'https://github.com/NotAShelf/direnv.nvim' }
require('direnv').setup()
