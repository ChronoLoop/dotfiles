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
        file_ignore_patterns = { '%.git/', 'node_modules/', 'coverage/', '__pycache__/', '%.o' },
        mappings = {
            i = {
                ['<C-k>'] = telescope_actions.move_selection_previous,
                ['<C-j>'] = telescope_actions.move_selection_next,
            },
        },
    },
})
