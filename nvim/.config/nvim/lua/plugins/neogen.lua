vim.pack.add { 'https://github.com/danymat/neogen' }

require('neogen').setup()

vim.keymap.set('n', '<localleader>nd', function() require('neogen').generate() end, { desc = '[N]eogen generate [D]oc' })
vim.keymap.set('n', '<localleader>nf', function() require('neogen').generate { type = 'func' } end, { desc = '[N]eogen generate [F]unc' })
vim.keymap.set('n', '<localleader>nc', function() require('neogen').generate { type = 'class' } end, { desc = '[N]eogen generate [C]lass' })
vim.keymap.set('n', '<localleader>nt', function() require('neogen').generate { type = 'type' } end, { desc = '[N]eogen generate [T]ype' })
