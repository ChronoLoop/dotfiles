return {
    'stevearc/conform.nvim',
    dependencies = {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
        local conform_ok, conform = pcall(require, 'conform')
        if not conform_ok then
            return
        end

        local mason_tool_installer_ok, mason_tool_installer = pcall(require, 'mason-tool-installer')
        if not mason_tool_installer_ok then
            return
        end

        mason_tool_installer.setup({
            ensure_installed = {
                'alex',
                'eslint_d',
                'flake8',
                'hadolint',

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
        })
    end,
}
