return {
    'sindrets/diffview.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local diffview = require('diffview')
        diffview.setup({
            view = {
                merge_tool = {
                    layout = 'diff3_mixed',
                },
            },
        })
        local keymap = require('kevin.keymap')
        local nnoremap = keymap.nnoremap

        local function toggle_diffview(cmd)
            if next(require('diffview.lib').views) == nil then
                vim.cmd(cmd)
            else
                vim.cmd('DiffviewClose')
            end
        end

        nnoremap('<leader>gd', function()
            toggle_diffview('DiffviewOpen')
        end, {
            desc = 'Toggle Diffview Index',
        })

        nnoremap('<leader>gD', function()
            toggle_diffview('DiffviewOpen HEAD~')
        end, {
            desc = 'Toggle Diffview Last Commit',
        })

        nnoremap('<leader>gf', function()
            toggle_diffview('DiffviewFileHistory %')
        end, {
            desc = 'Toggle DiffviewFileHistory for Current File',
        })

        nnoremap('<leader>gF', function()
            toggle_diffview('DiffviewFileHistory')
        end, {
            desc = 'Toggle DiffviewFileHistory',
        })
    end,
}
