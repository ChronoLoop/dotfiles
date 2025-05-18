--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
require('kevin.set')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require('lazy')
lazy.setup('kevin.plugins')

require('kevin.keybindings')
require('kevin.keymap')

require('kevin.autocommands')
require('kevin.lsp')
require('kevin.custom.toggle-checkbox')
