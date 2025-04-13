return {
    'mfussenegger/nvim-lint',
    dependencies = {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
        local lint_ok, lint = pcall(require, 'lint')
        if not lint_ok then
            return
        end

        local mason_tool_installer_ok, mason_tool_installer = pcall(require, 'mason-tool-installer')
        if not mason_tool_installer_ok then
            return
        end

        mason_tool_installer.setup({
            ensure_installed = {
                'alex',
                { 'eslint_d', version = '13.1.2' },
                'flake8',
                'hadolint',
            },
        })
        lint.linters_by_ft = {
            markdown = { 'alex' },
            python = { 'flake8' },
            docker = { 'hadolint' },
            javascript = { 'eslint_d' },
            javascriptreact = { 'eslint_d' },
            typescript = { 'eslint_d' },
            typescriptreact = { 'eslint_d' },
            svelte = { 'eslint_d' },
            vue = { 'eslint_d' },
        }
    end,
}
