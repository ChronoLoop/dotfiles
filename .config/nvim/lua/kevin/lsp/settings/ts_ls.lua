local function organize_imports()
    local params = {
        title = 'organize_imports',
        command = '_typescript.organizeImports',
        arguments = {
            vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()),
        },
    }

    local client = vim.lsp.get_clients({ name = 'ts_ls', bufnr = 0 })[1]
    client:exec_cmd(params, { bufnr = vim.api.nvim_get_current_buf() })
end

return {
    commands = {
        OrganizeImports = {
            organize_imports,
            description = 'Organize Imports',
        },
    },
    filetype = { 'typescript', 'typescriptreact', 'typescript.tsx' },
}
