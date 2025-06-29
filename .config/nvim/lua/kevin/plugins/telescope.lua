return {
    'nvim-lua/telescope.nvim',
    dependencies = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
        local status_ok, telescope = pcall(require, 'telescope')
        if not status_ok then
            return
        end

        local status_ok_1, telescope_actions = pcall(require, 'telescope.actions')
        if not status_ok_1 then
            return
        end

        telescope.setup({
            defaults = {
                file_ignore_patterns = { '%.git/', 'node_modules/', 'coverage/', '__pycache__/', '%.o', 'assets/' },
                mappings = {
                    i = {
                        ['<C-k>'] = telescope_actions.move_selection_previous,
                        ['<C-j>'] = telescope_actions.move_selection_next,
                        ['<C-a>'] = telescope_actions.results_scrolling_left,
                        ['<C-e>'] = telescope_actions.results_scrolling_right,
                        ['<C-h>'] = telescope_actions.preview_scrolling_left,
                        ['<C-l>'] = telescope_actions.preview_scrolling_right,
                    },
                },
            },
        })
    end,
}
