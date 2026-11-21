local servers = require('kevin.lsp.servers')

return {
    'hrsh7th/cmp-nvim-lsp',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        { 'antosha417/nvim-lsp-file-operations', config = true },
        { 'folke/lazydev.nvim', opts = {} },
    },
    config = function()
        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

        local default_config = {
            capabilities = capabilities,
        }

        local function config(_config)
            return vim.tbl_deep_extend('force', {
                capabilities = capabilities,
            }, _config or {})
        end

        for _, server in pairs(servers) do
            local has_custom_config, server_custom_config = pcall(require, 'kevin.lsp.settings.' .. server)
            vim.lsp.enable(server)
            if has_custom_config then
                vim.lsp.config(server, config(server_custom_config))
            else
                vim.lsp.config(server, default_config)
            end
        end
    end,
}
