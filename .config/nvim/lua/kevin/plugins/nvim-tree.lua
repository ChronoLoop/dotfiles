return {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
        local status_ok, nvim_tree = pcall(require, 'nvim-tree')
        if not status_ok then
            return
        end

        nvim_tree.setup({
            git = {
                ignore = false,
            },
            filters = {
                custom = { '^.git$' },
            },
            update_focused_file = {
                enable = true,
            },
        })
    end,
}
