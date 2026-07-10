-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function() vim.hl.on_yank() end,
})

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Trim trailing whitespace on save',
  callback = function()
    local ok, ts = pcall(require, 'mini.trailspace')
    if not ok then return end
    ts.trim()
    ts.trim_last_lines()
  end,
})

vim.api.nvim_create_user_command('UpdatePlugins', function() vim.pack.update() end, { desc = 'Update all plugins' })

vim.api.nvim_create_user_command('UpdatePluginsOffline', function() vim.pack.update(nil, { offline = true }) end, { desc = 'Update all plugins' })

-- Delete unused plugins
vim.api.nvim_create_user_command('RemoveUnusedPlugins', function()
  local inactive_plugins = vim.iter(vim.pack.get()):filter(function(x) return not x.active end):map(function(x) return x.spec.name end):totable()

  if #inactive_plugins == 0 then
    vim.print 'No unused plugins found.'
    return
  end

  vim.print('Removing:', inactive_plugins)
  local choice = vim.fn.confirm('Remove ' .. #inactive_plugins .. ' unused plugin(s)?', '&Yes\n&No', 2)
  if choice == 1 then
    vim.pack.del(inactive_plugins)
    vim.print(('Removed %d plugin(s).'):format(#inactive_plugins))
  else
    vim.print 'Aborted.'
  end
end, { desc = 'Remove unused plugins' })
