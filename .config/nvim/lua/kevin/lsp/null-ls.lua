local null_ls = require('null-ls')
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

require('mason-tool-installer').setup({
    ensure_installed = {
        'prettier',
        'stylua',
        'sqlfluff',
    },
})

local M = {}

M.setup = function(on_attach)
    null_ls.setup({
        debug = false,
        sources = {
            formatting.prettier,
            formatting.stylua,
            formatting.sqlfluff.with({
                extra_args = { '--dialect', 'postgres' }, -- change to your dialect
            }),
            diagnostics.sqlfluff.with({
                extra_args = { '--dialect', 'postgres' }, -- change to your dialect
            }),
        },
        on_attach = on_attach,
    })
end

return M
