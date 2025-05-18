local conform_ok, conform = pcall(require, 'conform')
if not conform_ok or not conform then
    return
end

-- Global diagnostic config
vim.diagnostic.config({
    underline = { severity_limit = 'Error' },
    signs = true,
    update_in_insert = false,
})

local disabled_lsp_formatters = {
    ts_ls = true,
    jsonls = true,
    html = true,
    lua_ls = true,
    clangd = true,
}

-- if you want to set up formatting on save, you can use this as a callback
local formatting_augroup = vim.api.nvim_create_augroup('LspFormatting', {})

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

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
        vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = buf })
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = formatting_augroup,
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

    local telescope_builtin = require('telescope.builtin')

    nmap('gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    nmap('gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    nmap('gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    nmap('gr', telescope_builtin.lsp_references)
    nmap('gw', telescope_builtin.lsp_document_symbols)
    nmap('gW', telescope_builtin.lsp_workspace_symbols)
    nmap('gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    nmap('<leader>le', '<cmd>lua vim.diagnostic.setloclist()<CR>')
    nmap('[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
    nmap(']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    nmap('<leader>p', '', {
        callback = function()
            format_buffer(buf, client.name)
        end,
    })

    nmap('K', function()
        vim.lsp.buf.hover({
            width = 80,
            border = 'single',
        })
    end)
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

-- local success_blink_cmp, blink_cmp = pcall(require, 'blink.cmp')
-- if success_blink_cmp then
--     capabilities = blink_cmp.get_lsp_capabilities(capabilities)
-- end

local success_cmp_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if success_cmp_lsp then
    capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
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
    'csharp_ls',
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
    vim.lsp.enable(server)
    if has_custom_config then
        vim.lsp.config(server, config(server_custom_config))
    else
        vim.lsp.config(server, default_config)
    end
end
