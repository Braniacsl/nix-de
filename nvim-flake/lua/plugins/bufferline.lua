local status, bufferline = pcall(require, "bufferline")
if not status then
  vim.notify("bufferline not found!", vim.log.levels.ERROR)
  return
end

bufferline.setup({
  options = {
    mode = "buffers",
    separator_style = "slant",
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
  },
})
