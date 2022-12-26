local null_ls = require('null-ls')
local formatting = null_ls.builtins.formatting
local completion = null_ls.builtins.completion
null_ls.setup {
    debug = false,
    sources = {
        formatting.prettier,
        formatting.stylua,
        formatting.sql_formatter,
        completion.spell
    }
}
