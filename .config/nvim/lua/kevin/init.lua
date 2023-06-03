--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
require('kevin.set')

require('kevin.autocommands')
require('kevin.autopairs')
require('kevin.bufferline')
require('kevin.cmp')
require('kevin.comment')
require('kevin.gitsigns')
require('kevin.indentline')
require('kevin.keybindings')
require('kevin.keymap')
require('kevin.lsp')
require('kevin.lualine')
require('kevin.nvim-colorizer')
require('kevin.nvim-tree')
require('kevin.nvim-tree-context')
require('kevin.plugins')
require('kevin.telescope')
require('kevin.treesitter')
require('kevin.dap')
require('kevin.oil')

-- themes
require('kevin.themes.tokyonight')

-- Go
require('kevin.gopher')
