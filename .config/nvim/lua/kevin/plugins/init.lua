return {
    -- Core
    'tpope/vim-fugitive',
    'mattn/emmet-vim',
    'windwp/nvim-ts-autotag',
    { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
        },
    },

    --Theme/Syntax
    'ryanoasis/vim-devicons',
    'kyazdani42/nvim-web-devicons',
}
