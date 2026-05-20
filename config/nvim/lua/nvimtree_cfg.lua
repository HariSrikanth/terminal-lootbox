-- ~/.config/nvim/lua/nvimtree_cfg.lua
local ok, nvimtree = pcall(require, 'nvim-tree')
if not ok then return end

-- Recommended by nvim-tree docs: disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup {
  view = {
    width = 35,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
}

-- Keymaps
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<leader>o', ':NvimTreeFindFile<CR>', { silent = true })
