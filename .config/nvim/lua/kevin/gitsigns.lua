local keymap = require('kevin.keymap')

require('gitsigns').setup({
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function nnoremap(l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            keymap.nnoremap(l, r, opts)
        end

        local function nvnoremap(l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            keymap.nvnoremap(l, r, opts)
        end

        -- Actions
        nvnoremap('<leader>hs', ':Gitsigns stage_hunk<CR>')
        nvnoremap('<leader>hr', ':Gitsigns reset_hunk<CR>')
        nnoremap('<leader>hu', gs.undo_stage_hunk)
        nnoremap('<leader>hp', gs.preview_hunk)

        nnoremap('<leader>hS', gs.stage_buffer)
        nnoremap('<leader>hR', gs.reset_buffer)

        nnoremap('<leader>hd', gs.diffthis)
        nnoremap('<leader>hD', function()
            gs.diffthis('~')
        end)

        nnoremap('<leader>hb', function()
            gs.blame_line({ full = true })
        end)

        nnoremap('<leader>tb', gs.toggle_current_line_blame)
        nnoremap('<leader>td', gs.toggle_deleted)
    end,
})
