vim.pack.add { 'https://github.com/kdheepak/lazygit.nvim' }

vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
vim.g.lazygit_config_file_path = '$HOME/.config/lazygit/config.yml'

vim.keymap.set('n', '<leader>lg', '<Cmd>LazyGit<Cr>', { desc = 'Toggle LazyGit' })
