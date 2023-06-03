local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
    return
end

nvim_tree.setup({
    git = {
        ignore = false,
    },
    filters = {
        custom = { '^node_modules$' },
    },
    update_focused_file = {
        enable = true,
        ignore_list = {
            '^.git$',
        },
    },
})
