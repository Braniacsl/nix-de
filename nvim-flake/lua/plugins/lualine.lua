local status, lualine = pcall(require, "lualine")
if not status then
  vim.notify("lualine not found!", vim.log.levels.ERROR)
  return
end

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "catppuccin",
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
})
