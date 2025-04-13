require('mason-tool-installer').setup({
    ensure_installed = {
        'alex',
        'eslint_d',
        'hadolint',
        'flake8',

        'black',
        'prettier',
        'stylua',
        'shfmt',
    },
})

local alex = require('efmls-configs.linters.alex')
local flake8 = require('efmls-configs.linters.flake8')
local hadolint = require('efmls-configs.linters.hadolint')
local eslint_d = require('efmls-configs.linters.eslint_d')

local black = require('efmls-configs.formatters.black')
local shfmt = require('efmls-configs.formatters.shfmt')
local stylua = require('efmls-configs.formatters.stylua')
local prettier = require('efmls-configs.formatters.prettier')

local languages = require('efmls-configs.defaults').languages()
languages = vim.tbl_extend('force', languages, {
    lua = { stylua },
    python = { flake8, black },
    yaml = { prettier },
    sh = { shfmt },
    markdown = { alex, prettier },
    docker = { hadolint, prettier },

    css = { prettier },
    scss = { prettier },
    html = { prettier },
    javascript = { eslint_d, prettier },
    javascriptreact = { eslint_d, prettier },
    typescript = { eslint_d, prettier },
    typescriptreact = { eslint_d, prettier },
    svelte = { eslint_d, prettier },
    vue = { eslint_d, prettier },
})

return {
    filetypes = vim.tbl_keys(languages),
    init_options = {
        documentFormatting = true,
    },
    settings = {
        rootMarkers = { '.git/' },
        languages = languages,
    },
}
