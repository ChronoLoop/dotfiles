-- -- Safely call command to set colorscheme
-- -- but do not stop execution
local colorscheme_cmd = 'colorscheme onedark'
local success, err = pcall(vim.cmd, colorscheme_cmd)
if not success then
    vim.api.nvim_err_writeln(err)
end

local c = require('onedark.colors')

require('onedark').setup({
    style = 'darker',
    highlights = {
        VertSplit = { bg = c.bg_d },
    },
})
require('onedark').load()
