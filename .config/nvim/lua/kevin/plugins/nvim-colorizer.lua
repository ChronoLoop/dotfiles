return {
    'NvChad/nvim-colorizer.lua',
    config = function()
        local status_ok, colorizer = pcall(require, 'colorizer')
        if not status_ok then
            return
        end

        colorizer.setup({
            user_default_options = {
                tailwind = true,
            },
        })
    end,
}
