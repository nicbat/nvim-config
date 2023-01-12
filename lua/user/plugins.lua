local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here

	-- defaults
	use "wbthomason/packer.nvim" -- packer manager itself
	use "nvim-lua/popup.nvim" -- implementation of the Popop API from vim in Neovim, supposedly a default plugin that other ones use
	use "nvim-lua/plenary.nvim" -- useful lua functions used in a lot of plugins

	-- plugins
	use 'sheerun/vim-polyglot'
	use 'windwp/nvim-autopairs' -- Autopairs, integrates with both cmp and treesitter
	use 'numToStr/Comment.nvim' -- easily comment stuff
	use 'kyazdani42/nvim-web-devicons'
	use 'kyazdani42/nvim-tree.lua' -- file explorer

	-- dashboard 
	use 'glepnir/dashboard-nvim'

	-- debug
	use 'mfussenegger/nvim-dap'
	-- git
	use { -- gitsigns
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	}
	use 'f-person/git-blame.nvim'

	-- lualine
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	-- use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
	use 'nanozuki/tabby.nvim'
	-- use 'nvim-lualine/lualine.nvim'
	-- use 'tamton-aquib/staline.nvim'

	--[[ -- cmp plugins ]]
	--[[ use({ "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" }) -- The completion plugin ]]
	--[[ use({ "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" }) -- buffer completions ]]
	--[[ use({ "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" }) -- path completions ]]
	--[[ use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions ]]
	--[[ use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }) ]]
	--[[ use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }) ]]
	--[[]]
	--[[ -- snippets ]]
	--[[ use({ "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" }) --snippet engine ]]
	--[[ use({ "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" }) -- a bunch of snippets to use ]]
	--[[]]
	--[[ -- LSP  ]]
	--[[ use({ "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" }) -- enable LSP ]]
	--[[ use({ "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" }) -- simple to use language server installer ]]
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" }) -- for formatters and linters

	-- LSP Progress
	 use 'j-hui/fidget.nvim'

	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}

	-- Telescope
	use "nvim-telescope/telescope.nvim"
	use "nvim-telescope/telescope-media-files.nvim"

	-- Treesitter
	use {
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	}
	use "p00f/nvim-ts-rainbow"
	use "nvim-treesitter/playground"
	use "JoosepAlviste/nvim-ts-context-commentstring"
	use "windwp/nvim-ts-autotag"
	use "nvim-treesitter/nvim-treesitter-context"
	-- themes
	use 'tjdevries/colorbuddy.nvim' -- plugin that a lot of themes use
	--[[ use 'bkegley/gloombuddy' ]]
	--[[ use 'folke/tokyonight.nvim' ]]
	--[[ use "EdenEast/nightfox.nvim" ]]
	use { "catppuccin/nvim", as ="catppuccin"}

	-- autoformatting
	use { 'prettier/vim-prettier', run = 'yarn install' }

	-- Java
	use { "mfussenegger/nvim-jdtls", ft = { "java" }}


	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
