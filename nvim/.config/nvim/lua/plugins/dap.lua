vim.pack.add {
  'https://github.com/jay-babu/mason-nvim-dap.nvim',
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/rcarriga/nvim-dap-ui',
}

local dap = require 'dap'
local dapui = require 'dapui'

-- Bridge Mason-installed debug adapters into nvim-dap automatically.
-- Install adapters with :MasonInstall <name>, e.g.:
--   :MasonInstall codelldb   (C / C++ / Rust via GDB/LLDB)
--   :MasonInstall debugpy    (Python)
--   :MasonInstall delve      (Go)
--   :MasonInstall js-debug-adapter  (JavaScript / TypeScript)
require('mason-nvim-dap').setup {
  automatic_installation = true,
}

dapui.setup()

-- Automatically open/close the UI when debugging starts/ends
dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

-- Breakpoints
vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, { desc = '[D]ebug: Toggle [B]reakpoint' })
vim.keymap.set('n', '<Leader>dB', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = '[D]ebug: Set Conditional [B]reakpoint' })

-- Step controls
vim.keymap.set('n', '<F5>', dap.continue, { desc = '[D]ebug: Continue' })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = '[D]ebug: Step Over' })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = '[D]ebug: Step Into' })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = '[D]ebug: Step Out' })

-- UI toggle
vim.keymap.set('n', '<Leader>du', dapui.toggle, { desc = '[D]ebug: Toggle [U]I' })
