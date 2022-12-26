require 'kevin.lsp.null-ls'
local lspconfig = require 'lspconfig'

-- Global diagnostic config
vim.diagnostic.config({
    underline = { severity_limit = "Error" },
    signs = true,
    update_in_insert = false,
})

-- Add border like lspsaga
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    width = 80,
    border = 'single',
})

-- Add border like lspsaga
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
    border = 'single',
})

-- Code action popup
-- but only use it if installed
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

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- disable formatting from tsserver, html, jsonls
            if client.name == 'tsserver'
                or client.name == 'jsonls' or client.name == 'html'
            then
                return false
            end

            if client.name == 'gopls' then
                vim.opt_local.expandtab = false
            end
            return true

        end,
        bufnr = bufnr,
    })
end

local function on_attach(client, bufnr)
    print('Attaching to ' .. client.name)

    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
            lsp_formatting(bufnr)
        end,
    })
    local nmap = function(keys, func, opts)
        local default_opts = { buffer = bufnr }
        opts = vim.tbl_extend("force", default_opts,
            opts or {}
        )

        vim.keymap.set('n', keys, func)
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
            lsp_formatting(bufnr)
        end
    })

    nmap('gr', require('telescope.builtin').lsp_references)

    -- Replacement for lspsaga
    nmap('K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    nmap('<leader>sh', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    nmap('<leader>af', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    nmap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

    nmap(
        '<leader>ls',
        string.format(
            '<cmd>lua vim.diagnostic.open_float(%d, %s)<CR>',
            bufnr,
            '{ width = 80, focusable = false, border = "single" }'
        )
    )


end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Only load cmp lsp capabilities when avaiabled
-- in case you uninstall nvim-cmp
local success_cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if success_cmp_lsp then
    capabilities = require 'cmp_nvim_lsp'.default_capabilities(vim.lsp.protocol.make_client_capabilities())
end

local default_config = {
    on_attach = on_attach,
    capabilities = capabilities,
}

local function config(_config)
    return vim.tbl_deep_extend("force", {
        on_attach = on_attach,
        capabilities = capabilities,
    }, _config or {})
end

local servers = {
    'bashls',
    'clangd',
    'cssls',
    'dockerls',
    'gopls',
    'html',
    'jsonls',
    'pyright',
    'rust_analyzer',
    'sumneko_lua',
    'tailwindcss',
    'tsserver',
    'vimls',
    'yamlls',
}

require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup {
    ensure_installed = servers,
    automatic_installation = true,
}

for _, server in pairs(servers) do
    local has_custom_config, server_custom_config = pcall(require, 'kevin.lsp.settings.' .. server)
    if has_custom_config then
        lspconfig[server].setup(config(server_custom_config))
    else
        lspconfig[server].setup(default_config)
    end

end
