vim.pack.add {
  'https://github.com/mfussenegger/nvim-dap',
  -- user interface
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/nvim-neotest/nvim-nio',
  -- debug adapters (native only; nix provides adapters via lspsAndRuntimeDeps)
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/jay-babu/mason-nvim-dap.nvim',
  -- debuggers
  'https://github.com/leoluz/nvim-dap-go',
  'https://github.com/mfussenegger/nvim-dap-python',
}

vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F1>', function() require('dap').step_into() end, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', function() require('dap').step_over() end, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', function() require('dap').step_out() end, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
vim.keymap.set('n', '<leader>B', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, { desc = 'Debug: Set Breakpoint' })
-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
vim.keymap.set('n', '<F7>', function() require('dapui').toggle() end, { desc = 'Debug: See last session result.' })

local dap = require 'dap'
local dapui = require 'dapui'

if not vim.g.is_nix then
  require('mason-nvim-dap').setup {
    automatic_installation = true,
    handlers = {},
    ensure_installed = {
      'cpptools',
      'delve',
      'debugpy',
    },
  }
end

dapui.setup {
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '⏭',
      step_out = '⏮',
      step_back = 'b',
      run_last = '▶▶',
      terminate = '⏹',
      disconnect = '⏏',
    },
  },
}

-- Change breakpoint icons
vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
local breakpoint_icons = vim.g.have_nerd_font
    and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
  or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
for type, icon in pairs(breakpoint_icons) do
  local tp = 'Dap' .. type
  local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
  vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
end

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

require('dap-go').setup {
  delve = {
    -- On Windows delve must be run attached or it crashes.
    -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    detached = vim.fn.has 'win32' == 0,
  },
}

if vim.g.is_nix then
  require('dap-python').setup(require('nixCats').extra.python3 .. '/bin/python3')
else
  require('dap-python').setup()
end

if vim.g.is_nix then
  -- pkgs.lldb provides lldb-dap, the built-in LLDB DAP adapter
  dap.adapters.codelldb = {
    type = 'executable',
    command = 'lldb-dap',
  }
else
  dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    executable = {
      command = vim.fn.expand '~/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb',
      args = { '--port', '${port}' },
    },
  }
end

dap.configurations = {
  python = {
    {
      name = 'Python Debugger: Current File',
      type = 'debugpy',
      request = 'launch',
      program = '${file}',
      args = {},
      console = 'integratedTerminal',
    },
  },
  cpp = {
    {
      name = '(gdb) Launch',
      type = 'cppdbg',
      request = 'launch',
      program = function()
        local result = nil
        require('mini.pick').start {
          source = {
            name = 'Select executable',
            cwd = vim.fn.getcwd(),
            items = vim.fn.systemlist { 'fd', '--type', 'x', '--no-ignore', '--absolute-path' },
            choose = function(item) result = item end,
          },
        }
        return result
      end,
      args = {},
      cwd = '${fileDirname}',
      environment = {},
      externalConsole = false,
      MIMode = 'gdb',
      setupCommands = {
        { text = 'set follow-fork-mode child', ignoreFailures = true },
      },
    },
    {
      name = '(lldb) Launch',
      type = 'codelldb',
      request = 'launch',
      program = function()
        local result = nil
        require('mini.pick').start {
          source = {
            name = 'Select executable',
            cwd = vim.fn.getcwd(),
            items = vim.fn.systemlist { 'fd', '--type', 'x', '--no-ignore', '--absolute-path' },
            choose = function(item) result = item end,
          },
        }
        return result
      end,
      args = {},
      cwd = '${fileDirname}',
      stopOnEntry = false,
    },
    {
      name = 'Attach to Python (GDB)',
      type = 'cppdbg',
      request = 'attach',
      processId = function() return require('dap.utils').pick_process { filter = 'python' } end,
      program = 'python',
      MIMode = 'gdb',
      setupCommands = { -- note: pretty printing config can mess with the debugger
        { text = 'set follow-fork-mode child', ignoreFailures = true },
      },
    },
  },
}
