vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

local function close_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_info = vim.fn.getbufinfo({buflisted = 1})

  if #buf_info <= 1 then
    vim.cmd("Oil")
  else
    vim.api.nvim_buf_delete(bufnr, {force = false})
  end
end

-- General
keymap("n", "<leader>c", close_buffer, { desc = "Close Buffer" })
keymap("n", "-", "<cmd>Oil<cr>", { desc = "Open Parent Directory" })
keymap("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer" })

-- Telescope
keymap("n", "<leader>?", "<cmd>Telescope keymaps<cr>", { desc = "Find Keymaps" })
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find Text" })
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find Buffers" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })

-- Diagnostics / Trouble
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
keymap("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo in Trouble" })
keymap("n", "<leader>e[", function() require("trouble").prev({severity = vim.diagnostic.severity.ERROR}) end, { desc = "Previous Error" })
keymap("n", "<leader>e]", function() require("trouble").next({severity = vim.diagnostic.severity.ERROR}) end, { desc = "Next Error" })
keymap("n", "<leader>w[", function() require("trouble").prev({severity = vim.diagnostic.severity.WARN}) end, { desc = "Previous Warning" })
keymap("n", "<leader>w]", function() require("trouble").next({severity = vim.diagnostic.severity.WARN}) end, { desc = "Next Warning" })

-- Window & Buffer Navigation
keymap("n", "<C-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
keymap("n", "<C-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous Buffer" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
