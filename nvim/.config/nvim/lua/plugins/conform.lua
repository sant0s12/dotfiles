require("conform").setup({
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
		tex = { "latexindent", stop_after_first = true }
	},
})
