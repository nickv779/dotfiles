require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>cpf", function ()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy current file to clipboard"} )

map("n", "<leader>cpd", function ()
  local cmd = "pwd"
  local out = vim.fn.system(cmd):gsub("\n$", "")
  vim.fn.setreg("+", out)
  vim.notify("Copied: " .. out)
end, { desc = "Copy current directory to clipboard" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- /Users/nicolasvaliente/.config/nvchad
--/Users/nicolasvaliente/.config/nvchad
--
