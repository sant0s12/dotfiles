-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	checker = { enabled = true },
	install = { colorscheme = { "gruvbox" } },
	spec = {
		{
			"neovim/nvim-lspconfig",
			dependencies = {
				-- Optional
				{
					"mason-org/mason.nvim",
					config = function()
						require("mason").setup()
					end,
				},
				{
					"mason-org/mason-lspconfig.nvim",
					config = function()
						require("mason-lspconfig").setup()
					end,
				},
				-- Autocompletion
				{
					"saghen/blink.cmp",
					version = "1.*",
					config = function()
						require("blink.cmp").setup({
							-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
							-- 'super-tab' for mappings similar to vscode (tab to accept)
							-- 'enter' for enter to accept
							-- 'none' for no mappings
							--
							-- All presets have the following mappings:
							-- C-space: Open menu or open docs if already open
							-- C-n/C-p or Up/Down: Select next/previous item
							-- C-e: Hide menu
							-- C-k: Toggle signature help (if signature.enabled = true)
							--
							-- See :h blink-cmp-config-keymap for defining your own keymap
							keymap = {
								preset = "enter",
								["<Tab>"] = { "select_next", "fallback" },
								["<S-Tab>"] = { "select_prev", "fallback" },
							},

							signature = { enabled = true },

							appearance = {
								-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
								-- Adjusts spacing to ensure icons are aligned
								nerd_font_variant = "mono",
							},

							-- (Default) Only show the documentation popup when manually triggered
							completion = { documentation = { auto_show = false } },

							-- Default list of enabled providers defined so that you can extend it
							-- elsewhere in your config, without redefining it, due to `opts_extend`
							sources = {
								default = { "lsp", "path", "snippets", "buffer" },
							},

							-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
							-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
							-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
							--
							-- See the fuzzy documentation for more information
							fuzzy = { implementation = "prefer_rust_with_warning" },
						})
					end,
				}, -- Required
				{ "L3MON4D3/LuaSnip" }, -- Required
			},

			config = function()
				-- LSP Keybindings
				vim.api.nvim_create_autocmd("LspAttach", {
					desc = "LSP actions",
					callback = function()
						local bufopts = { noremap = true, silent = true }

						vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
						vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
						vim.keymap.set("n", "K", function()
							vim.api.nvim_command("set eventignore=CursorHold")
							vim.lsp.buf.hover()
							vim.api.nvim_command('autocmd CursorMoved <buffer> ++once set eventignore=""')
						end, bufopts)
						vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
						vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
						vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
						vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
						vim.keymap.set("n", "<space>wl", function()
							print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
						end, bufopts)
						vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
						vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
						vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
						vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
					end,
				})
			end,
		},

		-- Grammar check
		{ "brymer-meneses/grammar-guard.nvim" },

		{
			"nvim-telescope/telescope.nvim",
			dependencies = { { "nvim-lua/plenary.nvim" } },
			config = function()
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
				vim.keymap.set("n", "<leader>fp", builtin.git_files, {})
				vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			end,
		},

		{
			"lervag/vimtex",
			dependencies = { "peterbjorgensen/sved" },
			config = function()
				-- vim.g.vimtex_view_method = 'Okular'
				-- vim.g.vimtex_quickfix_open_on_warning = 0

				vim.g.vimtex_view_general_viewer = "evince"

				vim.g.vimtex_compiler_latexmk_engines = {
					["_"] = "-xelatex",
					["pdflatex"] = "-pdf",
					["dvipdfex"] = "-pdfdvi",
					["lualatex"] = "-lualatex",
					["xelatex"] = "-xelatex",
					["context (pdftex)"] = "-pdf -pdflatex=texexec",
					["context (luatex)"] = "-pdf -pdflatex=context",
					["context (xetex)"] = "-pdf -pdflatex='texexec --xtx'",
				}

				-- https://tex.stackexchange.com/a/725188
				vim.g.vimtex_compiler_latexmk = {
					aux_dir = "aux", -- create a directory called aux that will contain all the auxiliary files
				}
			end,
		},
		{ "vim-pandoc/vim-pandoc" },
		{ "dhruvasagar/vim-table-mode" },
		{ "chrisbra/csv.vim" },

		{ "mbbill/undotree" },

		{
			"gruvbox-community/gruvbox",
			config = function()
				vim.cmd("colorscheme gruvbox")
				vim.opt.background = "dark"
			end,
		},

		{ "bronson/vim-trailing-whitespace" },

		{ "tpope/vim-fugitive" },

		{ "ahmedkhalf/project.nvim" },

		-- Better word motions
		{ "chaoren/vim-wordmotion" },

		-- Misc
		{ "eandrju/cellular-automaton.nvim" },
		{ "xiyaowong/telescope-emoji.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },

		-- Tailwind CSS colors{
		{ "roobert/tailwindcss-colorizer-cmp.nvim" },

		-- Docs generation
		{
			"danymat/neogen",
			config = function()
				require("neogen").setup({})
			end,
		},

		-- Github copilot
		{
			"zbirenbaum/copilot.lua",
			enabled = false,
			cmd = "Copilot",
			event = "InsertEnter",
			config = function()
				require("copilot").setup({
					suggestion = {
						auto_trigger = true,
					},
				})
			end,
		},

		-- Formatting
		{
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			keys = {
				{
					"<leader>F",
					function()
						require("conform").format({ async = true, lsp_format = "fallback" })
					end,
				},
			},
			opts = {
				format_on_save = {
					lsp_format = "fallback",
					timeout_ms = 500,
				},

				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform will run multiple formatters sequentially
					python = { "isort", "autopep8", "black", stop_after_first = false },
					-- Use a sub-list to run only the first available formatter
					javascript = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					nix = { "alejandra", "nixfmt", stop_after_first = true },
					c = { "clang_format", stop_after_first = true },
					cpp = { "clang_format", stop_after_first = true },
					tex = { "latexindent", stop_after_first = true },
				},
			},
		},

		-- Auto pairs
		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		},

		-- Toggleterm
		{
			"akinsho/toggleterm.nvim",
			opts = {
				open_mapping = [[<S-CR>]],
				insert_mappings = false, -- whether or not the open mapping applies in insert mode
				terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
				persist_mode = false, -- if set to true (default) the previous terminal mode will be remembered
				direction = "vertical",
				shading_factor = "-1",

				size = function(term)
					if term.direction == "horizontal" then
						return 20
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.45
					end
				end,
			},
		},

		-- Block comments
		{
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		},

		-- Indent lines
		{
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("ibl").setup()
			end,
		},

		-- Lualine
		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require("lualine").setup({ options = { theme = "gruvbox" } })
			end,
		},

		{
			"folke/todo-comments.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				require("todo-comments").setup({})
			end,
		},

		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},

		{ import = "plugins" },
	},
})
