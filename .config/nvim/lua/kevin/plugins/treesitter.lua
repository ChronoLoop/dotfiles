return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    config = function()
        local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
        if not status_ok then
            return
        end

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
            autopairs = {
                enable = true,
            },
            autotag = {
                enable = true,
            },
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
