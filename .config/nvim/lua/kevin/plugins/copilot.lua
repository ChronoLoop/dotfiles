return {
    'zbirenbaum/copilot.lua',
    dependencies = {
        'copilotlsp-nvim/copilot-lsp',
        lazy = true,
    },
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'InsertEnter',
    config = function()
        local auth_provider_url = vim.env.NEOVIM_COPILOT_AUTH_URL

        if auth_provider_url == '' then
            auth_provider_url = nil
        end
        require('copilot').setup({
            auth_provider_url = auth_provider_url,
            suggestion = {
                enabled = false,
            },
            panel = {
                enabled = false,
            },
        })
    end,
}
