require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'c',
        'cpp',
        'css',
        'graphql',
        'help',
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
        'go'
    },
    highlight = { enable = true },
    autopairs = {
        enable = true,
    },
    autotag = {
        enable = true
    },
    indent = {
        enable = true,
        disable = {},
    }
}
