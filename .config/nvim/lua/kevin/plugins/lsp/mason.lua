local servers = require('kevin.lsp.servers')

return {
    {
        'williamboman/mason-lspconfig.nvim',
        opts = {
            ensure_installed = servers,
            automatic_installation = true,
        },

        dependencies = {
            {
                'williamboman/mason.nvim',
                opts = {
                    ui = {
                        border = 'rounded',
                        icons = {
                            package_installed = '◍',
                            package_pending = '◍',
                            package_uninstalled = '◍',
                        },
                    },
                    log_level = vim.log.levels.INFO,
                    max_concurrent_installers = 4,
                },
            },
            'neovim/nvim-lspconfig',
        },
    },
}
