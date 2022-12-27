local null_ls = require('null-ls')
local formatting = null_ls.builtins.formatting

require('mason-tool-installer').setup({
    ensure_installed = {
        'prettier',
        'stylua',
    },
})

local M = {}

M.setup = function(on_attach)
    null_ls.setup({
        debug = false,
        sources = {
            formatting.prettier,
            formatting.stylua,
        },
        on_attach = on_attach,
    })
end

return M
