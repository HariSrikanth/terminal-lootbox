-- ~/.config/nvim/lua/gitsigns_cfg.lua
local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then return end

gitsigns.setup()

-- Optional keymaps (good defaults)
vim.keymap.set('n', ']h', gitsigns.next_hunk)
vim.keymap.set('n', '[h', gitsigns.prev_hunk)
vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk)
vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk)
vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk)
