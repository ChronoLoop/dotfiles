require('mason-tool-installer').setup({
    ensure_installed = {
        'alex',
        'black',
        'flake8',
        'prettier',
        'stylua',
        'eslint_d',

        'fixjson',
        'hadolint',
        'shfmt',
    },
})

local alex = require('efmls-configs.linters.alex')
local black = require('efmls-configs.formatters.black')
local eslint_d = require('efmls-configs.linters.eslint_d')
local fixjson = require('efmls-configs.formatters.fixjson')
local flake8 = require('efmls-configs.linters.flake8')
local hadolint = require('efmls-configs.linters.hadolint')
local prettier = require('efmls-configs.formatters.prettier')
local shfmt = require('efmls-configs.formatters.shfmt')
local stylua = require('efmls-configs.formatters.stylua')

local languages = require('efmls-configs.defaults').languages()
languages = vim.tbl_extend('force', languages, {
    -- Custom languages, or override existing ones
    lua = { stylua },
    python = { flake8, black },
    typescript = { eslint_d, prettier },
    json = { eslint_d, fixjson, prettier },
    jsonc = { eslint_d, fixjson, prettier },
    yaml = { prettier },
    sh = { shfmt },
    markdown = { alex, prettier },
    docker = { hadolint, prettier },

    css = { prettier },
    scss = { prettier },
    html = { prettier },
    javascript = { eslint_d, prettier },
    javascriptreact = { eslint_d, prettier },
    typescriptreact = { eslint_d, prettier },
    svelte = { eslint_d, prettier },
    vue = { eslint_d, prettier },
})

return {
    filetypes = {
        'lua',
        'python',
        'json',
        'jsonc',
        'yaml',
        'sh',
        'markdown',
        'docker',
        'solidity',

        'css',
        'scss',
        'html',
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'svelte',
        'vue',
    },
    init_options = {
        documentFormatting = true,
    },
    settings = {
        rootMarkers = { '.git/' },
        languages = languages,
    },
}
