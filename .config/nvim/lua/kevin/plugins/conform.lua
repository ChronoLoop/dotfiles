return {
    'stevearc/conform.nvim',
    dependencies = {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    event = {
        'BufReadPre',
        'BufNewFile',
    },
    config = function()
        local conform = require('conform')
        local mason_tool_installer = require('mason-tool-installer')

        mason_tool_installer.setup({
            ensure_installed = {
                'black',
                'prettier',
                'stylua',
                'shfmt',
            },
        })

        conform.setup({
            formatters_by_ft = {
                sh = { 'shfmt' },
                markdown = { 'prettier' },
                docker = { 'prettier' },

                css = { 'prettier' },
                scss = { 'prettier' },
                html = { 'prettier' },
                yaml = { 'prettier' },

                lua = { 'stylua' },
                python = { 'black' },
                rust = { 'rustfmt' },

                javascript = { 'prettier' },
                javascriptreact = { 'prettier' },
                typescript = { 'prettier' },
                typescriptreact = { 'prettier' },
                svelte = { 'prettier' },
                vue = { 'prettier' },
            },
            format_on_save = {
                async = false,
            },
        })
    end,
}
