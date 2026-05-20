-- ~/.config/nvim/init.lua

-- Leader key
vim.g.mapleader = " "

-- Basic settings
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
-- vim.opt.termguicolors = true  -- Disabled: conflicts with terminal color settings
vim.cmd("syntax on")  -- Enable basic vim syntax highlighting

-- Load plugins (packer)
local ok_plugins, _ = pcall(require, 'plugins')
if not ok_plugins then
  return
end

-- Theme (bootstrap-safe)
pcall(vim.cmd, "colorscheme sonokai")

-- Plugin configs (bootstrap-safe by their own pcalls)
require('treesitter')
require('telescope_cfg')
require('gitsigns_cfg')
require('nvimtree_cfg')
