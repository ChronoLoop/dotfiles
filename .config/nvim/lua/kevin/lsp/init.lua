local lspconfig_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_ok or not lspconfig then
    return
end

local conform_ok, conform = pcall(require, 'conform')
if not conform_ok or not conform then
    return
end

local lint_ok, lint = pcall(require, 'lint')
if not lint_ok or not lint then
    return
end

-- Global diagnostic config
vim.diagnostic.config({
    underline = { severity_limit = 'Error' },
    signs = true,
    update_in_insert = false,
})

-- Code action popup
local success_lsputils, lsputils_codeAction = pcall(require, 'lsputil.codeAction')
if success_lsputils then
    if vim.fn.has('nvim-0.6') == 1 then
        vim.lsp.handlers['textDocument/codeAction'] = lsputils_codeAction.code_action_handler
    else
        vim.lsp.handlers['textDocument/codeAction'] = function(_, _, actions)
            lsputils_codeAction.code_action_handler(nil, actions, nil, nil, nil)
        end
    end
end

local disabled_lsp_formatters = {
    ts_ls = true,
    jsonls = true,
    html = true,
    lua_ls = true,
    clangd = true,
}

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

local lsp_formatting = function(buf)
    vim.lsp.buf.format({
        filter = function(client)
            return not disabled_lsp_formatters[client.name]
        end,
        bufnr = buf,
    })
end

local format_buffer = function(buf, name)
    if not disabled_lsp_formatters[name] then
        lsp_formatting(buf)
    end

    lint.try_lint()
    conform.format({ bufnr = buf })
end

local function set_client_tab(client)
    if client.name == 'clangd' then
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
        vim.opt.shiftwidth = 2
    elseif client.name == 'jsonls' then
        vim.opt.expandtab = false
    end
end

local function cursor_highlight(client, buf)
    if client and client.server_capabilities.documentHighlightProvider then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
            end,
        })
    end
end

local function on_attach(client, buf)
    -- print('Attaching to ' .. client.name)

    if client.supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = buf })
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = buf,
            callback = function()
                format_buffer(buf, client.name)
            end,
        })
    end

    set_client_tab(client)
    cursor_highlight(client, buf)

    local nmap = function(keys, func, opts)
        local default_opts = { buffer = buf }
        opts = vim.tbl_extend('force', default_opts, opts or {})

        vim.keymap.set('n', keys, func, opts)
    end

    nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    nmap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    nmap('gw', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
    nmap('gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
    nmap('gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    nmap('<leader>le', '<cmd>lua vim.diagnostic.setloclist()<CR>')
    nmap('[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    nmap(']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    nmap('<leader>p', '', {
        callback = function()
            format_buffer(buf, client.name)
        end,
    })

    nmap('gr', require('telescope.builtin').lsp_references)

    nmap('K', function()
        vim.lsp.buf.hover({
            width = 80,
            border = 'single',
        })
    end)
    nmap('<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    nmap('<leader>sh', function()
        vim.lsp.buf.signature_help({
            border = 'single',
        })
    end)
    nmap('<leader>af', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    nmap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

    nmap('<leader>ls', string.format('<cmd>lua vim.diagnostic.open_float(%d, %s)<CR>', buf, '{ width = 80, focusable = false, border = "single" }'))

    -- Go
    nmap('<leader>gsj', ':GoTagAdd json -transform camelcase<CR>', { desc = 'Add json struct tags' })
    nmap('<leader>gsy', ':GoTagAdd yaml -transform camcelcase<CR>', { desc = 'Add yaml struct tags' })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local success_blink_cmp, blink_cmp = pcall(require, 'blink.cmp')
if success_blink_cmp then
    capabilities = blink_cmp.get_lsp_capabilities(capabilities)
end

local default_config = {
    on_attach = on_attach,
    capabilities = capabilities,
}

local function config(_config)
    return vim.tbl_deep_extend('force', {
        on_attach = on_attach,
        capabilities = capabilities,
    }, _config or {})
end

local servers = {
    'astro',
    'bashls',
    'clangd',
    'cssls',
    'dockerls',
    'gopls',
    'html',
    'jsonls',
    'pyright',
    'rust_analyzer',
    'lua_ls',
    'svelte',
    'ts_ls',
    'tailwindcss',
    'vimls',
    'yamlls',
}

local status_ok, mason = pcall(require, 'mason')
if not status_ok then
    return
end

local status_ok_1, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status_ok_1 then
    return
end

mason.setup({
    ui = {
        border = 'rounded',
        icons = {
            package_installed = '◍',
            package_pending = '◍',
            package_uninstalled = '◍',
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
})

mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
})

for _, server in pairs(servers) do
    local has_custom_config, server_custom_config = pcall(require, 'kevin.lsp.settings.' .. server)
    if has_custom_config then
        lspconfig[server].setup(config(server_custom_config))
    else
        lspconfig[server].setup(default_config)
    end
end
