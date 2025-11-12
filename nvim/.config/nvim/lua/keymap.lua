vim.keymap.set('n', '+', '<C-w>+')
vim.keymap.set('n', '-', '<C-w>-')

vim.keymap.set('n', '<leader>+', '<C-w>>')
vim.keymap.set('n', '<leader>-', '<C-w><')

vim.keymap.set('n', '<leader>h', ':wincmd h<CR>')
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>')
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>')
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>s', ':sp<CR>')
vim.keymap.set('n', '<leader>v', ':vsp<CR>')

vim.keymap.set('n', 'tl', ':tabnext<CR>')
vim.keymap.set('n', 'th', ':tabprevious<CR>')
vim.keymap.set('n', '<leader>t', ':tabnew<CR>')

vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>')

vim.keymap.set('n', '<F6>', ':setlocal spell! spelllang=en_us <CR>')

-- Ctrl-CR for floating terminal
vim.keymap.set('n', '<C-CR>', ':ToggleTerm direction=float <CR>')

-- Esc to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Goto previous/next diagnostic warning/error
vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, { silent = true })

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')

vim.keymap.set('n', '<leader>gg', ':Git<space>')
vim.keymap.set('n', '<leader>gs', ':Git<CR>')
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>')
vim.keymap.set('n', '<leader>gd', ':G diff<CR>')
vim.keymap.set('n', '<leader>ga', ':G add<space>')
vim.keymap.set('n', '<leader>gp', ':G push<CR>')
vim.keymap.set('n', '<leader>gP', ':G pull<CR>')

vim.keymap.set('n', 'gl', ':VimtexView<CR>')

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set('n', '<space>F', function() require('conform').format({ async = true, lsp_fallback = true }) end)

vim.keymap.set("n", "<Leader>d", function() require('neogen').generate() end, opts)

-- LSP Keybindings
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
	  local bufopts = { noremap = true, silent = true, buffer = bufnr }

	  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	  vim.keymap.set('n', 'K', function()
		vim.api.nvim_command('set eventignore=CursorHold')
		vim.lsp.buf.hover()
		vim.api.nvim_command('autocmd CursorMoved <buffer> ++once set eventignore=""')
	  end, bufopts)
	  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	  vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	  end, bufopts)
	  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	  end
})

