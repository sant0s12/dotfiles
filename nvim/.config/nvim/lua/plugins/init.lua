local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local function get_config(name)
	return string.format('require("plugins/%s")', name)
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			-- Optional
			{
				"dundalek/lazy-lsp.nvim",
				requires = { "neovim/nvim-lspconfig" },
				config = get_config("lazy-lsp")
			},
			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'L3MON4D3/LuaSnip' }, -- Required

			-- Extra sources
			{ 'FelipeLema/cmp-async-path' },
		},
		config = get_config("lsp")
	}

	-- Grammar check
	use 'brymer-meneses/grammar-guard.nvim'

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = get_config("nvim-treesitter") }

	use {
		'nvim-telescope/telescope.nvim', branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } },
		config = get_config("telescope")
	}

	use { 'lervag/vimtex', config = get_config("vimtex") }
	use { 'vim-pandoc/vim-pandoc' }
	use 'dhruvasagar/vim-table-mode'
	use 'chrisbra/csv.vim'

	use 'mbbill/undotree'

	use 'gruvbox-community/gruvbox'
	use 'chrisbra/SudoEdit.vim'
	use 'bronson/vim-trailing-whitespace'

	use 'tpope/vim-fugitive'

	use { 'ahmedkhalf/project.nvim', config = get_config("project-nvim") }

	-- File explorer
	use { 'kyazdani42/nvim-tree.lua',
		requires = { 'nvim-tree/nvim-web-devicons' },
		config = get_config("nvim-tree")
	}

	-- Better word motions
	use 'chaoren/vim-wordmotion'

	-- Misc
	use 'eandrju/cellular-automaton.nvim'
	use { 'xiyaowong/telescope-emoji.nvim', requires = { 'nvim-telescope/telescope.nvim' } }
	use 'wakatime/vim-wakatime'

	-- Flutter tools
	use {
		'akinsho/flutter-tools.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
			'stevearc/dressing.nvim', -- optional for vim.ui.select
		},
	}

	-- Tailwind CSS colorsuse({
	use 'roobert/tailwindcss-colorizer-cmp.nvim'

	-- Docs generation
	use {
		"danymat/neogen",
		config = function()
			require('neogen').setup {}
		end
	}

	-- Github copilot
	use {
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true
				}
			})
		end,
	}

	-- Formatting
	use({ "stevearc/conform.nvim", config = get_config("conform") })

	-- Auto pairs
	use {
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup {}
		end
	}

	-- Toggleterm
	use {
		"akinsho/toggleterm.nvim",
		tag = '*',
		config = get_config("toggleterm")
	}

	-- Block comments
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}

	-- Indent lines
	use {
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup()
		end
	}

	-- Lualine
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons' },
		config = function() require('lualine').setup({ options = { theme = 'gruvbox' } }) end
	}

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
