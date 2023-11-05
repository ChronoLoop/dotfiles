return {
    'olexsmir/gopher.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
    },
    build = ':GoInstallDeps',
    config = function()
        local status_ok, gopher = pcall(require, 'gopher')
        if not status_ok then
            return
        end
        gopher.setup({
            commands = {
                go = 'go',
                gomodifytags = 'gomodifytags',
                gotests = 'gotests',
                impl = 'impl',
                iferr = 'iferr',
            },
        })
    end,
}
