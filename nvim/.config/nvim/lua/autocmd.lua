-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function() vim.hl.on_yank() end,
})


vim.api.nvim_create_user_command('UpdatePlugins', function()
  vim.pack.update()
end, { desc = 'Update all plugins' })

-- Delete unused plugins
vim.api.nvim_create_user_command('RemoveUnusedPlugins', function()
  local inactive_plugins = vim.iter(vim.pack.get())
      :filter(function(x) return not x.active end)
      :map(function(x) return x.spec.name end)
      :totable()

  if #inactive_plugins == 0 then
    vim.print("No unused plugins found.")
    return
  end

  vim.print("Removing:", inactive_plugins)
  local choice = vim.fn.confirm("Remove " .. #inactive_plugins .. " unused plugin(s)?", "&Yes\n&No", 2)
  if choice == 1 then
    vim.pack.del(inactive_plugins)
    vim.print(("Removed %d plugin(s)."):format(#inactive_plugins))
  else
    vim.print("Aborted.")
  end
end, { desc = 'Remove unused plugins' })
