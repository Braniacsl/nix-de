local opt = vim.opt

opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.scrolloff = 8

opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

opt.wrap = true 
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.mouse = "a"
opt.clipboard = "unnamedplus"

vim.loader.enable()
