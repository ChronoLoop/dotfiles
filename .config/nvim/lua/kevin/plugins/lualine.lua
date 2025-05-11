return {
    'hoob3rt/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
    config = function()
        local status_ok, lualine = pcall(require, 'lualine')
        if not status_ok then
            return
        end

        -- favorites: nightfly, tokyonight
        lualine.setup({
            options = { theme = 'tokyonight', section_separators = '', component_separators = '' },
            sections = {
                lualine_c = {
                    {
                        'filename',
                        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
                    },
                },
                lualine_x = {
                    { 'fileformat', 'filetype' },
                    {
                        require('noice').api.statusline.mode.get,
                        cond = require('noice').api.statusline.mode.has,
                        color = { fg = '#ff9e64' },
                    },
                },
            },
        })
    end,
}
