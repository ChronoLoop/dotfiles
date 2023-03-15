local function open_nvim_tree()
    require('nvim-tree.api').tree.toggle({
        focus = false,
    })
end

local function autocmd_callback()
    open_nvim_tree()
    pcall(require('nvim-treesitter.install').update({ with_sync = true }))
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = autocmd_callback })
