-- Persistent folding: save and restore fold state across sessions.
-- Uses a per-buffer flag so loadview only runs once per buffer (on first
-- entry), avoiding repeated disk reads on every window switch.
vim.api.nvim_create_autocmd({ 'BufWinLeave', 'BufWritePost', 'WinLeave' }, {
  desc = 'Save fold state when leaving a buffer',
  callback = function(args)
    if vim.b[args.buf].view_activated then pcall(vim.cmd.mkview) end
  end,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Restore fold state the first time a buffer is entered',
  callback = function(args)
    if not vim.b[args.buf].view_activated then
      local buftype = vim.bo[args.buf].buftype
      local filetype = vim.bo[args.buf].filetype
      if buftype == '' and filetype ~= '' then
        vim.b[args.buf].view_activated = true
        pcall(vim.cmd.loadview)
      end
    end
  end,
})

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
