return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        indent = {
            enabled = true,
            animate = { enabled = false },
        },
        input = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = false },
        explorer = { enabled = false },
        picker = { enabled = false },
        scroll = { enabled = false },
    },
    keys = {
        {
            '<leader>:',
            function()
                local Snacks = require('snacks')
                Snacks.picker.command_history()
            end,
            desc = 'Command History',
        },
        {
            '<leader>sn',
            function()
                local Snacks = require('snacks')
                Snacks.picker.notifications()
            end,
            desc = 'Notification History',
        },
    },
}
