vim.pack.add { 'https://github.com/dlyongemallo/diffview-plus.nvim' }

require('diffview').setup()

-- Resolve origin's default branch, fall back to origin/main
local default_branch = vim.fn.systemlist('git symbolic-ref --short refs/remotes/origin/HEAD')[1]
if vim.v.shell_error ~= 0 or not default_branch or default_branch == '' then default_branch = 'origin/main' end

-- List local and remote branches for selection, with the default branch first.
local function branch_choices()
  local branches = vim.fn.systemlist(
    "git for-each-ref --format='%(refname:short)' refs/heads refs/remotes"
  )
  if vim.v.shell_error ~= 0 then branches = {} end
  local choices, seen = {}, {}
  for _, b in ipairs({ default_branch, unpack(branches) }) do
    if b and b ~= '' and b ~= 'origin/HEAD' and not seen[b] then
      seen[b] = true
      table.insert(choices, b)
    end
  end
  return choices
end

vim.keymap.set('n', '<Leader>do', '<CMD>DiffviewOpen<CR>', { desc = 'Show Diffview UI' })
vim.keymap.set('n', '<Leader>dom', '<CMD>DiffviewOpen ' .. default_branch .. '...HEAD<CR>',
  { desc = 'Show Diffview UI Relative to Main' })
vim.keymap.set('n', '<Leader>doM', function()
  vim.ui.select(branch_choices(), { prompt = 'Diff against (fork base):' }, function(base)
    if base and base ~= '' then vim.cmd('DiffviewOpen ' .. base .. '...HEAD') end
  end)
end, { desc = 'Show Diffview UI Relative to Selected Base' })
vim.keymap.set('n', '<Leader>dh', '<CMD>DiffviewFileHistory<CR>', { desc = 'Show Diffview File History UI' })
vim.keymap.set('n', '<Leader>df', '<CMD>DiffviewFileHistory %<CR>',
  { desc = 'Show Diffview File History UI on current file' })
vim.keymap.set(
  'n',
  '<Leader>dhm',
  '<CMD>DiffviewFileHistory --range=' .. default_branch .. '..HEAD<CR>',
  { desc = 'Show Diffview File History UI Relative to Main' }
)
