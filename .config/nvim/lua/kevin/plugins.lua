local packer = require('packer')

packer.startup(function(use)
    -- Telescope
    use({ 'nvim-lua/telescope.nvim', requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' } })

    -- Core
    use('wbthomason/packer.nvim')
    use({
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- optional, for file icons
        },
    })
    use('tpope/vim-fugitive')
    use('tpope/vim-surround')
    use('numToStr/Comment.nvim')
    use({ 'akinsho/nvim-bufferline.lua', tag = 'v3.*', requires = 'kyazdani42/nvim-web-devicons' })
    use('mattn/emmet-vim')
    use('windwp/nvim-autopairs')
    use('windwp/nvim-ts-autotag')
    use({ 'lewis6991/gitsigns.nvim' })
    use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })
    use('jose-elias-alvarez/null-ls.nvim')

    --debugging
    use({ 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } })
    use('leoluz/nvim-dap-go')
    use('theHamsta/nvim-dap-virtual-text')

    -- LSP
    use({
        'neovim/nvim-lspconfig',
        requires = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
        },
    })

    -- Autocompletion
    use({
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp-signature-help',
        },
    })

    -- Snippets
    use('L3MON4D3/LuaSnip')
    use('rafamadriz/friendly-snippets')

    --Theme/Syntax
    use('ryanoasis/vim-devicons')
    use('kyazdani42/nvim-web-devicons')
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    use('nvim-treesitter/nvim-treesitter-context')
    use('JoosepAlviste/nvim-ts-context-commentstring')
    use('navarasu/onedark.nvim')
    use('folke/tokyonight.nvim')
    use({ 'hoob3rt/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } })
    use('lukas-reineke/indent-blankline.nvim')
    use('onsails/lspkind.nvim')
    use('NvChad/nvim-colorizer.lua')

    --Go
    use({
        'olexsmir/gopher.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        run = ':GoInstallDeps',
    })
end)
