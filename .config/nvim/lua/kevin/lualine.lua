-- favorites: nightfly, tokyonight
require('lualine').setup({
    options = { theme = 'tokyonight', section_separators = '', component_separators = '' },
    sections = {
        lualine_c = {
            {
                'filename',
                path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
        },
    },
})
