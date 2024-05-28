-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- File Explorer

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  }

  use "nvim-lua/plenary.nvim" -- don't forget to add this one if you don't have it yet!
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Go plugins
  use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua' -- recommended if need floating window support

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { { "nvim-lua/plenary.nvim" } }
  }
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    }
  }
  --  use('jose-elias-alvarez/null-ls.nvim')
  use('christoomey/vim-tmux-navigator')

  --[[
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine-main')
    end
  })
  ]]--
  use({
    "folke/tokyonight.nvim",
    as = 'tokyonight',
    config = function()
      vim.cmd('colorscheme tokyonight')
    end
  })
  use("vrischmann/tree-sitter-templ")

  -- use 'mfussenegger/nvim-jdtls'
  --  use 'mikelue/vim-maven-plugin('
end)
