return {
    'akinsho/nvim-bufferline.lua',
    version = '*',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = function()
        local status_ok, bufferline = pcall(require, 'bufferline')
        if not status_ok then
            return
        end

        bufferline.setup()
    end,
}
