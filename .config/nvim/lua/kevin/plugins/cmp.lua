return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'roobert/tailwindcss-colorizer-cmp.nvim',
        'onsails/lspkind.nvim',
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

    config = function()
        local lspkind_ok, lspkind = pcall(require, 'lspkind')
        if not lspkind_ok or not lspkind then
            return
        end
        local cmp_status_ok, cmp = pcall(require, 'cmp')
        if not cmp_status_ok or not cmp then
            return
        end

        local luasnip_status_ok, luasnip = pcall(require, 'luasnip')
        if not luasnip_status_ok then
            return
        end

        local tail_col_cmp_ok, tailwindcss_colorizer_cmp = pcall(require, 'tailwindcss-colorizer-cmp')
        if not tail_col_cmp_ok then
            return
        end

        local cmp_autopairs_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
        if not cmp_autopairs_ok then
            return
        end

        local check_backspace = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
        end

        -- Setup nvim-cmp
        cmp.event:on('confirm_done', function(args)
            local line = vim.api.nvim_get_current_line()
            -- prevent adding parentheses when importing functional components (eg. <Foo)
            local is_component_import = line:match('<%s*[%w_%d]+$')
            if is_component_import then
                return false
            end
            cmp_autopairs.on_confirm_done()(args)
        end)

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            mapping = {
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.jumpable(1) then
                        luasnip.jump(1)
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif luasnip.expandable() then
                        luasnip.expand()
                    elseif check_backspace() then
                        fallback()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<C-e>'] = cmp.mapping({
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                }),
                ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                ['<Esc>'] = cmp.mapping(function(fallback)
                    luasnip.unlink_current() -- fix: unfinished snippet causing code to be duplicated (https://github.com/L3MON4D3/LuaSnip/discussions/675, https://github.com/L3MON4D3/LuaSnip/issues/656)
                    fallback()
                end),
            },
            -- You should specify your *installed* sources.
            sources = {
                { name = 'nvim_lsp_signature_help' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
                { name = 'render-markdown' },
            },
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol_text', -- show only symbol annotations
                    maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    before = function(entry, item)
                        item = tailwindcss_colorizer_cmp.formatter(entry, item)
                        item.menu = ({
                            buffer = '[Buffer]',
                            nvim_lsp = '[LSP]',
                            luasnip = '[Snippet]',
                            path = '[Path]',
                        })[entry.source.name]

                        return item
                    end,
                }),
            },
            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            preselect = cmp.PreselectMode.None,
        })
    end,
}
