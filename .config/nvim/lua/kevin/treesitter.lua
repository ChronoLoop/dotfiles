local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

configs.setup({
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
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
})
