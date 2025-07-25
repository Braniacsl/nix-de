local status, catppuccin = pcall(require, "catppuccin")
if not status then
  vim.notify("catppuccin theme not found!", vim.log.levels.ERROR)
  return
end

catppuccin.setup({
  flavour = "mocha",
})

vim.cmd.colorscheme("catppuccin")
