vim.pack.add {
  'https://github.com/NeogitOrg/neogit',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/m00qek/baleia.nvim',
}

vim.keymap.set('n', '<Leader>gg', '<CMD>Neogit<CR>', { desc = 'Show Neogit UI' })

require('neogit').setup {
  -- log_pager = { 'delta', '--width', '117', '--dark' },
  log_pager = { 'delta', '--width', '117', '--dark', "--syntax-theme", "OneHalfDark" },
}

vim.g.baleia = require("baleia").setup({})

-- Command to colorize the current buffer
vim.api.nvim_create_user_command("BaleiaColorize", function()
  vim.g.baleia.once(vim.api.nvim_get_current_buf())
end, { bang = true })

-- Command to show logs
vim.api.nvim_create_user_command("BaleiaLogs", vim.cmd.messages, { bang = true })

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = "*.log",
  callback = function()
    vim.g.baleia.automatically(vim.api.nvim_get_current_buf())
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = "quickfix",
  callback = function()
    vim.api.nvim_set_option_value("modifiable", true, { buf = buffer })
    vim.g.baleia.automatically(vim.api.nvim_get_current_buf())
    vim.api.nvim_set_option_value("modified", false, { buf = buffer })
    vim.api.nvim_set_option_value("modifiable", false, { buf = buffer })
  end,
})
