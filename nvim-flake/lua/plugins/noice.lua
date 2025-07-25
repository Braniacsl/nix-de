local status, noice = pcall(require, "noice")
if not status then return end

noice.setup({
  -- lsp = {
  --   override = {
  --     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --     ["vim.lsp.util.stylize_markdown"] = true,
  --   },
  -- },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
  },
  views = {
    whichkey_popup = {
      backend = "popup",
      position = {
        row = "50%",
        col = "100%",
        anchor = "topright",
      },
      size = {
        width = "auto",
        height = "auto",
      },
      border = {
        style = "rounded",
        padding = { 1, 2 },
      },
    },
  },
  routes = {
    {
      filter = {
        event = "show",
        kind = "which_key",
      },
      view = "whichkey_popup",
    },
  },
})
