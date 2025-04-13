return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {},
    config = function()
        require('render-markdown').setup({
            completions = { lsp = { enabled = true } },
            render_modes = { 'n' },
            anti_conceal = { enabled = true, above = 1, below = 1 },
        })
    end,
}
