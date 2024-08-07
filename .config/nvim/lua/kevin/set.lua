-- ==================================================================================== Initialize
-- ====================================================================================
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable provider for only python3 and node
vim.g.python3_host_prog = vim.fn.exepath('python3')
vim.g.loaded_python_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- ====================================================================================
-- Options
-- ====================================================================================

vim.opt.number = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.errorbells = false
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.hidden = true
vim.opt.signcolumn = 'yes'
vim.opt.backup = false
vim.opt.updatetime = 300
vim.opt.wrap = false
vim.opt.cursorline = true

-- disable adding new line to end of file on save
vim.opt.fixeol = false

-- https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'

vim.opt.list = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.showtabline = 2

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append({ c = true })

-- ====================================================================================
-- Theme
-- ====================================================================================

vim.opt.termguicolors = true
vim.opt.relativenumber = true
