return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    config = function()
        local configs = require('nvim-treesitter.configs')

        configs.setup({
            ensure_installed = {
                'astro',
                'c',
                'c_sharp',
                'cpp',
                'css',
                'graphql',
                'html',
                'javascript',
                'json',
                'lua',
                'rust',
                'python',
                'tsx',
                'typescript',
                'sql',
                'scss',
                'svelte',
                'go',
            },
            highlight = { enable = true },
            indent = {
                enable = true,
                disable = {},
            },
            sync_install = false,
            auto_install = true,
            ignore_install = {},
            modules = {},
        })
    end,
}
