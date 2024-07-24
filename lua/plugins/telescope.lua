return {
  'nvim-telescope/telescope.nvim', tag = '0.1.6',
  dependencies = { 
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
    'sharkdp/fd',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    {"<leader>ff","<cmd>Telescope find_files<cr>"},
    {"<leader>fg","<cmd>Telescope live_grep<cr>"},
    {"<leader>ft","<cmd>Telescope git_files<cr>"},
    {"<leader>fb","<cmd>Telescope buffers<cr>"},
    {"<leader>fh","<cmd>Telescope help_tags<cr>"},
  }
}
