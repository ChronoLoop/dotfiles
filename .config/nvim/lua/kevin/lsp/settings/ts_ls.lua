local ts_ls_utils = require('kevin.lsp.utils.ts_ls')

return {
    commands = {
        OrganizeImports = {
            ts_ls_utils.organize_imports,
            description = 'Organize Imports',
        },
    },
    filetype = { 'typescript', 'typescriptreact', 'typescript.tsx' },
}
