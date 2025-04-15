return {
    'saghen/blink.cmp',
    dependencies = {
        'Kaiser-Yang/blink-cmp-git',
        'Kaiser-Yang/blink-cmp-dictionary',
        {
            'L3MON4D3/LuaSnip',
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
            ['<C-p>'] = { 'snippet_backward', 'fallback' },
            ['<C-n>'] = { 'snippet_forward', 'fallback' },
        },
        appearance = {
            nerd_font_variant = 'mono',
        },
        completion = {
            ghost_text = { enabled = true },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = true,
                },
            },
            trigger = {
                show_on_trigger_character = true,
            },
            documentation = { auto_show = true, auto_show_delay_ms = 0, window = { border = 'rounded', max_width = 70 } },
            menu = {
                draw = {
                    columns = { { 'kind_icon' }, { 'label' }, { 'kind' } },
                },
            },
        },

        sources = {
            default = { 'buffer', 'lsp', 'snippets', 'path', 'omni' },
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
        signature = { enabled = true },
    },
    opts_extend = { 'sources.default' },
}
