local M = {}

function M.organize_imports()
    local params = {
        title = 'organize_imports',
        command = '_typescript.organizeImports',
        arguments = {
            vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
            {
                mode = 'RemoveUnused',
            },
        },
    }

    local clients = vim.lsp.get_clients({ name = 'ts_ls', bufnr = vim.api.nvim_get_current_buf() })
    if #clients == 0 then
        return
    end
    local client = clients[1]

    client:exec_cmd(params, { bufnr = vim.api.nvim_get_current_buf() })
end

return M
