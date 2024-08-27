return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()

      cmp.setup({
        formatting = lsp_zero.cmp_format({ details = true }),
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          ['<CR>'] = cmp.mapping.confirm({ select = true })
        }),
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
    },
    keys = {
      {"<leader>e","<cmd>:lua vim.diagnostic.open_float()<cr>"},
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)
      -- changed part
      function on_attach(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
      end
      ---
      ---
      -- (Optional) Configure lua language server for neovim
      local lua_opts  = lsp_zero.nvim_lua_ls()
      require('lspconfig').rust_analyzer.setup(lua_opts)
      --require('lspconfig').rust_analyzer.setup({
      --  settings = {
      --    ['rust-analyzer'] = {
      --      check = {
      --        command = 'clippy';
      --      }
      --    }
      --  }
      --})
      require('lspconfig').gopls.setup(lua_opts)
      require('lspconfig').pylsp.setup(lua_opts)
      require('lspconfig').bashls.setup(lua_opts)
      require('lspconfig').clangd.setup(lua_opts)
      require('lspconfig').cmake.setup(lua_opts)
      require('lspconfig').marksman.setup(lua_opts)
      require('lspconfig').nil_ls.setup(lua_opts)
      require('lspconfig').zls.setup(lua_opts)
      require('lspconfig').yamlls.setup(lua_opts)
      --require('lspconfig').pyright.setup(lua_opts)
      require('lspconfig').jsonls.setup(lua_opts)
    end
  }
}
