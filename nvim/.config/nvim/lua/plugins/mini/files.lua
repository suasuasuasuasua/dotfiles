-- Toggle dotfiles (show git tracked)
local show_dotfiles = true
local filter_show = function(fs_entry) return true end
local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, '.') end
local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  MiniFiles.refresh { content = { filter = new_filter } }
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak left-hand side of mapping to your liking
    vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
  end,
})

require('mini.files').setup {
  -- prevents bug with git difftool -d with nvim.difftool
  options = { use_as_default_explorer = false },
  -- content = { filter = filter_git },
}

-- Create mappings to modify target window via split ~
local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    -- Make new window and set it as target
    local cur_target = MiniFiles.get_explorer_state().target_window
    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. ' split')
      return vim.api.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target)

    -- This intentionally doesn't act on file under cursor in favor of
    -- explicit "go in" action (`l` / `L`). To immediately open file,
    -- add appropriate `MiniFiles.go_in()` call instead of this comment.
    MiniFiles.go_in()
  end

  -- Adding `desc` will result into `show_help` entries
  local desc = 'Split ' .. direction
  vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    -- Tweak keys to your liking
    map_split(buf_id, '<C-s>', 'belowright horizontal')
    map_split(buf_id, '<C-v>', 'belowright vertical')
    map_split(buf_id, '<C-t>', 'tab')
  end,
})

-- Create mappings which use data from entry under cursor ~
--
-- Set focused directory as current working directory
local set_cwd = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then return vim.notify 'Cursor is not on valid entry' end
  vim.fn.chdir(vim.fs.dirname(path))
end

-- Yank in register full path of entry under cursor
local yank_path = function()
  local path = (MiniFiles.get_fs_entry() or {}).path
  if path == nil then return vim.notify 'Cursor is not on valid entry' end
  vim.fn.setreg(vim.v.register, path)
end

-- Open path with system default handler (useful for non-text files)
local ui_open = function() vim.ui.open(MiniFiles.get_fs_entry().path) end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local b = args.data.buf_id
    vim.keymap.set('n', 'g~', set_cwd, { buffer = b, desc = 'Set cwd' })
    vim.keymap.set('n', 'gX', ui_open, { buffer = b, desc = 'OS open' })
    vim.keymap.set('n', 'gy', yank_path, { buffer = b, desc = 'Yank path' })
  end,
})

-- Toggle explorer
local minifiles_toggle = function(...)
  if not MiniFiles.close() then MiniFiles.open(...) end
end

vim.keymap.set('n', '-', function()
  local path = vim.api.nvim_buf_get_name(0)
  minifiles_toggle(path ~= '' and path or vim.fn.getcwd())
end, { desc = 'Open parent directory' })
