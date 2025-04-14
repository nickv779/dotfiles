-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "vscode_dark",
  transparency = true,
	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.ui = {
  cmp = {
    style = "flat_light",
    format_colors = {
      tailwind = true,
    },
  },
  statusline = {
    theme = "vscode",
  },
}

M.nvdash = {
  load_on_startup = true,
}

M.lsp = { signature = false }

return M
