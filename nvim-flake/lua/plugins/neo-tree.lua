local status, neo_tree = pcall(require, "neo-tree")
if not status then return end

neo_tree.setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  window = {
    position = "left",
    width = 30,
  },

  event_handlers = {
    {
      event = "VimEnter",
      handler = function()
        if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv()[1]) ~= 0 then
          vim.cmd("Neotree")
        end
      end,
    },
  },
})
