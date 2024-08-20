return {
  {
    'nyoom-engineering/oxocarbon.nvim',
    -- cottmckendry/cyberdream.nvim
    config = function()
      vim.opt.background = "dark" -- set this to dark or light
      --vim.cmd("colorscheme oxocarbon")
    end
  },
  {
    'GustavoPrietoP/doom-themes.nvim',
    config = function()
      vim.opt.background = "dark" -- set this to dark or light
      vim.cmd("colorscheme doom-monokai-classic")
    end
  }
}
