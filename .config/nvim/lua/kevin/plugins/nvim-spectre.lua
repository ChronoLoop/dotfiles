return {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local status_ok, spectre = pcall(require, 'spectre')
        if not status_ok then
            return
        end

        spectre.setup()
    end,
}
