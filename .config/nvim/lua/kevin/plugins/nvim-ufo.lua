return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    opts = {
        filetype_exclude = { 'help', 'nvim-tree', 'lazy', 'mason' },
        provider_selector = function(bufnr, filetype, buftype)
            return { 'lsp', 'indent' }
        end,
    },
    config = function(_, opts)
        local ufoOK, ufo = pcall(require, 'ufo')
        if not ufoOK then
            return
        end

        vim.o.foldcolumn = '1'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        local keymap = require('kevin.keymap')
        local nnoremap = keymap.nnoremap

        nnoremap('zR', ufo.openAllFolds, {
            desc = 'Open all folds',
        })
        nnoremap('zM', ufo.closeAllFolds, {
            desc = 'Close all folds',
        })

        local function peek()
            local winid = ufo.peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end

        nnoremap('zK', peek, {
            desc = 'Peek fold',
        })

        ufo.setup(opts)
    end,
}
