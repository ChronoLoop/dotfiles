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
                'ruff',
                'prettier',
                'stylua',
                'shfmt',
                'biome',
            },
        })

        local function get_js_formatters(bufnr)
            local has_biome = vim.fs.find({ 'biome.json', 'biome.jsonc' }, {
                upward = true,
                path = vim.api.nvim_buf_get_name(bufnr),
            })[1]

            if has_biome then
                return { 'prettier', 'biome', 'biome-organize-imports' }
            end

            return { 'prettier' }
        end

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
                python = { 'ruff' },
                rust = { 'rustfmt' },

                javascript = get_js_formatters,
                javascriptreact = get_js_formatters,
                typescript = get_js_formatters,
                typescriptreact = get_js_formatters,
                svelte = { 'prettier' },
                vue = { 'prettier' },
            },
            format_on_save = {
                async = false,
            },
        })
    end,
}
