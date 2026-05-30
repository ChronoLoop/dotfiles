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
        require('copilot').setup({
            suggestion = {
                enabled = false,
            },
            panel = {
                enabled = false,
            },
        })
    end,
}
