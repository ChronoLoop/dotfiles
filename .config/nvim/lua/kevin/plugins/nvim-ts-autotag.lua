return {
    'windwp/nvim-ts-autotag',
    config = function()
        local nvim_ts_autotag = require('nvim-ts-autotag')

        nvim_ts_autotag.setup({
            opts = {
                enable_close = true, -- Auto close tags
                enable_rename = true, -- Auto rename pairs of tags
                enable_close_on_slash = false, -- Auto close on trailing </
            },
        })
    end,
}
