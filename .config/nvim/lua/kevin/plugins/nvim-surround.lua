return {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        local status_ok, nvim_surround = pcall(require, 'nvim-surround')
        if not status_ok then
            return
        end

        nvim_surround.setup({})
    end,
}
