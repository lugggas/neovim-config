-- ensure that packer is installed
local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')

local packer = require'packer'
local util = require'packer.util'

packer.init({
    package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

--- startup and add configure plugins
packer.startup(function()
    local use = use
    -- add you plugins here like:
    use 'wbthomason/packer.nvim'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'sheerun/vim-polyglot'
    use {
        'prettier/vim-prettier',
        run = 'yarn install'
    }
    use 'sainnhe/sonokai'
    use 'neovim/nvim-lspconfig'
    use 'anott03/nvim-lspinstall'
    use 'nvim-lua/plenary.nvim'
    use 'jose-elias-alvarez/nvim-lsp-ts-utils'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- You don't need to install this if you already have fzf installed
    use {
        'junegunn/fzf',
        run = './install --all'
    }
    use { 'ibhagwan/fzf-lua',
      -- optional for icon support
		requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            { 'hrsh7th/cmp-vsnip' },
            { 'hrsh7th/vim-vsnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
        }
    }
    use 'chrisbra/unicode.vim'
    use 'simrat39/rust-tools.nvim'
    use { 'akinsho/toggleterm.nvim' }
end
)

vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost init.lua source <afile> | PackerCompile
    augroup end
]])
