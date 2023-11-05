return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
        local status_ok, indent_blankline = pcall(require, 'ibl')
        if not status_ok then
            return
        end

        indent_blankline.setup({
            scope = {
                enabled = true,
                show_start = true,
            },
            indent = {
                tab_char = '│',
            },
        })
    end,
}
