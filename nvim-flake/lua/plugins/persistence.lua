local status, persistence = pcall(require, "persistence")
if not status then return end

persistence.setup({
  dir = vim.fn.stdpath("data") .. "/sessions/",
  options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" },
})
