vim.pack.add { 'https://github.com/barrettruth/canola.nvim' }

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

local function parse_output(proc)
  local result = proc:wait()
  local ret = {}
  if result.code == 0 then
    for line in vim.gsplit(result.stdout, '\n', { plain = true, trimempty = true }) do
      line = line:gsub('/$', '')
      ret[line] = true
    end
  end
  return ret
end

local function new_git_status()
  return setmetatable({}, {
    __index = function(self, key)
      local ignore_proc = vim.system({ 'git', 'ls-files', '--ignored', '--exclude-standard', '--others', '--directory' }, {
        cwd = key,
        text = true,
      })
      local tracked_proc = vim.system({ 'git', 'ls-tree', 'HEAD', '--name-only' }, {
        cwd = key,
        text = true,
      })
      local ret = {
        ignored = parse_output(ignore_proc),
        tracked = parse_output(tracked_proc),
      }

      rawset(self, key, ret)
      return ret
    end,
  })
end
local git_status = new_git_status()

local refresh = require('oil.actions').refresh
local orig_refresh = refresh.callback
refresh.callback = function(...)
  git_status = new_git_status()
  orig_refresh(...)
end

local function oil_run_on_selection(opts)
  opts = opts or {}
  local oil = require 'oil'
  local bufnr = vim.api.nvim_get_current_buf()

  -- find the visual range bounds
  local start_line = vim.fn.line 'v'
  local end_line = vim.fn.line '.'
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  -- aggregate the files over the range
  local dir = oil.get_current_dir()
  local paths = {}
  for lnum = start_line, end_line do
    local entry = oil.get_entry_on_line(bufnr, lnum)
    if entry then table.insert(paths, vim.fn.fnameescape(dir .. entry.name)) end
  end
  if #paths == 0 then return end -- short circuit on empty range

  -- runs the command for each file (not clumped or variadic style)
  --
  -- as an example, let's say we've selected a visual range containing a.txt, b.txt, and c.txt
  --   dir/
  --     a.txt
  --     b.txt
  --     c.txt
  --     d.txt
  --     ...
  --
  -- implicitly passes each of the files in the range to the end of the command
  --   :chmod +x
  -- explicitly defines where the placeholder file belongs
  --   :mv {} /tmp/
  local prefix = opts.prefix or ''
  vim.ui.input({ prompt = opts.prompt or 'Cmd ({} = file): ' }, function(cmd)
    if not cmd or cmd == '' then return end
    cmd = prefix .. cmd
    for _, path in ipairs(paths) do
      local expanded = cmd:find('{}', 1, true) and cmd:gsub('{}', path) or (cmd .. ' ' .. path)
      vim.cmd(expanded)

      require('oil.actions').refresh.callback()
    end
  end)
end

local detail = false
require('oil').setup {
  view_options = {
    is_hidden_file = function(name, bufnr)
      local dir = require('oil').get_current_dir(bufnr)
      local is_dotfile = vim.startswith(name, '.') and name ~= '..'
      if not dir then return is_dotfile end
      if is_dotfile then
        return not git_status[dir].tracked[name]
      else
        return git_status[dir].ignored[name]
      end
    end,
  },
  keymaps = {
    ['<C-l>'] = 'actions.select',
    ['<C-h>'] = { 'actions.parent', mode = 'n' },
    ['<C-x>'] = { 'actions.select', opts = { horizontal = true } },
    ['<C-s>'] = false,
    ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
    ['<C-r>'] = { 'actions.refresh' },
    ['y.'] = { 'actions.copy_entry_path' },
    ['<C-f>'] = { 'actions.preview_scroll_down' },
    ['<C-b>'] = { 'actions.preview_scroll_up' },
    ['gd'] = {
      desc = 'Toggle file detail view',
      callback = function()
        detail = not detail
        if detail then
          require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
        else
          require('oil').set_columns { 'icon' }
        end
      end,
    },
    ['<leader>sf'] = {
      function()
        require('mini.pick').builtin.files {
          cwd = require('oil').get_current_dir(),
        }
      end,
      mode = 'n',
      nowait = true,
      desc = 'Find files in the current directory',
    },
    ['<leader>:'] = {
      callback = function() oil_run_on_selection { prefix = '!', prompt = 'Shell cmd ({} = file): ' } end,
      mode = { 'n', 'v' },
      desc = 'Run shell command on selected files',
    },
    ['<leader><leader>:'] = {
      callback = function() oil_run_on_selection { prompt = 'Ex cmd ({} = file): ' } end,
      mode = { 'n', 'v' },
      desc = 'Run Ex command on selected files',
    },
  },
}
