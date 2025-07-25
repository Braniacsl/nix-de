local status, telescope = pcall(require, "telescope")
if not status then return end

local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    path_display = { "truncate" },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      },
    },
  },
})

-- Load the fzf native extension
telescope.load_extension("fzf")
