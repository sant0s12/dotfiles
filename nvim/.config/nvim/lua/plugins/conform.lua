require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "autopep8", "black" },
    -- Use a sub-list to run only the first available formatter
    javascript = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    nix = { { "alejandra", "nixfmt" } },
    c = { { "clang_format" } },
    cpp = { { "clang_format" } },
    tex = { { "latexindent" } }
  },
})
