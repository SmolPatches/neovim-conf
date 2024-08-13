-- options
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.relativenumber = true
-- spacing
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.opt.clipboard = 'unnamedplus' -- share clipboard with system
-- plugin manager (lazy)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
local builtin = require('telescope.builtin')
local line = require('lualine').setup()
function toggle_ro() -- toggle readonly mode
  vim.o.readonly = not vim.o.readonly
end
-- key binds
-- Note this makes load unlazy
--local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>bn', "<cmd>bnext<cr>") -- go back to previous buffer
vim.keymap.set('n', '<leader>bp', "<cmd>bprev<cr>") -- go forward to next buffer
vim.keymap.set('n', '<leader>bd', "<cmd>bdelete<cr>") -- go forward to next buffer
vim.keymap.set('n', '<leader>.', "<cmd>e .<cr>") -- go forward to next buffer
vim.keymap.set('n', '<leader>r', "<cmd>lua toggle_ro()<cr>") -- binding for toggle readonly mode
