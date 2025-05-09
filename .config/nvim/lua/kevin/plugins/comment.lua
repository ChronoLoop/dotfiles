return {
    'numToStr/Comment.nvim',
    config = function()
        local status_ok, comment = pcall(require, 'Comment')
        if not status_ok then
            return
        end

        comment.setup({
            ignore = '^$',
            pre_hook = function(ctx)
                require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()

                if
                    vim.bo.filetype == 'javascript'
                    or vim.bo.filetype == 'typescript'
                    or vim.bo.filetype == 'javascriptreact'
                    or vim.bo.filetype == 'typescriptreact'
                then
                    local U = require('Comment.utils')

                    -- Determine whether to use linewise or blockwise commentstring
                    local type = ctx.ctype == U.ctype.linewise and '__default' or '__multiline'

                    -- Determine the location where to calculate commentstring from
                    local location = nil
                    if ctx.ctype == U.ctype.blockwise then
                        location = require('ts_context_commentstring.utils').get_cursor_location()
                    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
                        location = require('ts_context_commentstring.utils').get_visual_start_location()
                    end

                    if location == nil then
                        return require('ts_context_commentstring.internal').calculate_commentstring()
                    end

                    return require('ts_context_commentstring.internal').calculate_commentstring({
                        key = type,
                        location = location,
                    })
                end
            end,
        })
    end,
}
