-- ~/.config/nvim/lua/treesitter.lua
local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then
  return
end

configs.setup {
  ensure_installed = { "lua", "python", "javascript", "typescript", "c", "cpp" },
  highlight = { enable = false },  -- Disabled until parsers are installed
}
