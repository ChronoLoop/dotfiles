return {
    'saghen/blink.cmp',
    dependencies = {
        { 'Kaiser-Yang/blink-cmp-git' },
        { 'Kaiser-Yang/blink-cmp-dictionary' },
        {
            'L3MON4D3/LuaSnip', -- Snippets plugin
            dependencies = {
                'rafamadriz/friendly-snippets',
            },
            config = function()
                -- Load "friendly-snippets" (dependency):
                require('luasnip.loaders.from_vscode').lazy_load()
            end,
        },
    },
    version = '1.*',
    opts = {
        keymap = {
            preset = 'none',
            ['<CR>'] = { 'accept', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'fallback' },
            ['<Tab>'] = { 'select_next', 'fallback' },
            ['<C-e>'] = { 'hide', 'fallback' },
            ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        appearance = {
            nerd_font_variant = 'mono',
        },
        completion = {
            ghost_text = { enabled = true },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                },
            },
            trigger = {
                show_on_trigger_character = true,
            },
            documentation = { auto_show = true, window = { border = 'rounded' } },
            menu = {
                draw = {
                    padding = 0,
                    columns = { { 'kind_icon', gap = 1 }, { gap = 1, 'label' }, { 'kind', gap = 2 } },
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                return ' ' .. ctx.kind_icon .. ' '
                            end,
                            highlight = function(ctx)
                                return 'BlinkCmpKindIcon' .. ctx.kind
                            end,
                        },
                        kind = {
                            text = function(ctx)
                                return ' ' .. ctx.kind .. ' '
                            end,
                        },
                    },
                },
            },
        },
        sources = {
            default = { 'buffer', 'lsp', 'snippets', 'path' },
            providers = {
                git = {
                    module = 'blink-cmp-git',
                    name = 'Git',
                    enabled = function()
                        return vim.tbl_contains({ 'octo', 'gitcommit', 'markdown' }, vim.bo.filetype)
                    end,
                    opts = {},
                },
                dictionary = {
                    module = 'blink-cmp-dictionary',
                    name = 'Dict',
                    min_keyword_length = 3,
                    opts = {},
                },
            },
        },
        fuzzy = { implementation = 'prefer_rust' },
        snippets = {
            preset = 'luasnip',
        },
    },
    opts_extend = { 'sources.default' },
}
