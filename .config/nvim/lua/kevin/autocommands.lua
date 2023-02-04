local function open_nvim_tree()
    require('nvim-tree.api').tree.toggle({
        focus = false,
    })
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })
