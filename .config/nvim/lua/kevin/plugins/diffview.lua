return {
    'sindrets/diffview.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local diffview = require('diffview')
        diffview.setup({
            view = {
                merge_tool = {
                    layout = 'diff3_mixed',
                },
            },
        })
    end,
}
