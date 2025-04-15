return {
    'mfussenegger/nvim-lint',
    dependencies = {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    event = {
        'BufReadPre',
        'BufNewFile',
    },
    config = function()
        local lint = require('lint')
        local mason_tool_installer = require('mason-tool-installer')

        mason_tool_installer.setup({
            ensure_installed = {
                'alex',
                { 'eslint_d', version = '13.1.2' },
                'pylint',
                'hadolint',
            },
        })

        lint.linters.eslint_d.args = {
            '--no-color',
            '--format',
            'visualstudio',
            '--no-warn-ignored',
            '--stdin-filename',
            function()
                return vim.api.nvim_buf_get_name(0)
            end,
            '--stdin',
        }

        lint.linters_by_ft = {
            markdown = { 'alex' },
            python = { 'pylint' },
            docker = { 'hadolint' },
            javascript = { 'eslint_d' },
            javascriptreact = { 'eslint_d' },
            typescript = { 'eslint_d' },
            typescriptreact = { 'eslint_d' },
            svelte = { 'eslint_d' },
            vue = { 'eslint_d' },
        }

        local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = lint_augroup,
            callback = function()
                if vim.opt_local.modifiable:get() then
                    lint.try_lint()
                end
            end,
        })

        local keymap = require('kevin.keymap')
        local nnoremap = keymap.nnoremap
        nnoremap('<leader>l', function()
            lint.try_lint()
        end, { desc = 'Trigger linting for current file' })
    end,
}
