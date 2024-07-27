return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    require("dapui").setup()

    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
    dap.adapters.lldb = {
      type = "executable",
      command = "/Users/r3b/.nix-profile/bin/lldb-vscode",
      name = 'lldb'
    }
    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        -- CHANGE THIS to your path!
        command = '/Users/r3b/Downloads/extension/adapter/codelldb',
        args = { "--port", "${port}" },

        -- On windows you may have to uncomment this:
        -- detached = false,
      }
    }
    dap.adapters.delve = {
      type = 'server',
      port = '${port}',
      executable = {
        command = 'dlv',
        args = { 'dap', '-l', '127.0.0.1:${port}' },
        -- add this if on windows, otherwise server won't open successfully
        -- detached = false
      }
    }
    local dap = require('dap')
dap.configurations.rust = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}
    -- golang dap
    -- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
    dap.configurations.go = {
      {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}"
      },
      {
        type = "delve",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}"
      },
      -- works with go.mod packages and sub packages
      {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}"
      }
    }
    vim.keymap.set("n", "<Leader>dt", ':DapToggleBreakpoint<CR>')
    vim.keymap.set("n", "<Leader>dx", ':DapTerminate<CR>')
    vim.keymap.set("n", "<Leader>do", ':DapStepOver<CR>')
  end
}
