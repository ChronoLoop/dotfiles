local function open_nvim_tree(data)
    -- buffer is a real file on the disk
    local real_file = vim.fn.filereadable(data.file) == 1

    -- buffer is a [No Name]
    local no_name = data.file == '' and vim.bo[data.buf].buftype == ''

    if not real_file and not no_name then
        return
    end

    -- open the tree, find the file but don't focus it
    require('nvim-tree.api').tree.toggle({ focus = false, find_file = true })
end

local function autocmd_callback(data)
    open_nvim_tree(data)
    pcall(require('nvim-treesitter.install').update({ with_sync = true }))
end

vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = autocmd_callback })

vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained' }, {
    command = 'checktime',
})

-- https://github.com/razzmatazz/csharp-language-server/issues/119
local original_show_message = vim.lsp.handlers['window/showMessage']

vim.lsp.handlers['window/showMessage'] = function(err, result, context, config)
    local client = vim.lsp.get_client_by_id(context.client_id)

    local message_type = context and context.message_type
    if client and client.name == 'csharp_ls' then
        if message_type ~= 1 then
            -- Suppress non-error messages
            return
        end
    end

    return original_show_message(err, result, context, config)
end

-- Refresh nvim-tree after fugitive commands are completed
vim.api.nvim_create_autocmd('User', {
    pattern = 'FugitiveChanged',
    callback = function()
        vim.schedule(function()
            require('nvim-tree.api').tree.reload()
        end)
    end,
})
