return {
    'windwp/nvim-ts-autotag',
    config = function()
        local nvim_ts_autotag = require('nvim-ts-autotag')

        nvim_ts_autotag.setup()
    end,
}
