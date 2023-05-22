vim.keymap.set('n', '+', 			'<C-w>+')
vim.keymap.set('n', '-', 			'<C-w>-')

vim.keymap.set('n', '<leader>+', 	'<C-w>>')
vim.keymap.set('n', '<leader>-', 	'<C-w><')

vim.keymap.set('n', '<leader>h', 	':wincmd h<CR>')
vim.keymap.set('n', '<leader>j', 	':wincmd j<CR>')
vim.keymap.set('n', '<leader>k', 	':wincmd k<CR>')
vim.keymap.set('n', '<leader>l', 	':wincmd l<CR>')

vim.keymap.set('n', '<leader>s', 	':sp<CR>')
vim.keymap.set('n', '<leader>v', 	':vsp<CR>')

vim.keymap.set('n', 'tl', 			':tabnext<CR>')
vim.keymap.set('n', 'th', 			':tabprevious<CR>')
vim.keymap.set('n', '<leader>t', 	':tabnew<CR>')

vim.keymap.set('n', '<leader>u', 	':UndotreeToggle<CR>')

vim.keymap.set('n', '<F6>', 		':setlocal spell! spelllang=en_us <CR>')
vim.keymap.set('n', '<Enter>', 		'o<ESC>')

-- Shift-S for terminal in new tab
vim.keymap.set('n', '<S-s>', 		':tabnew | term<CR>')

-- Ctrl-S for terminal in new tab
vim.keymap.set('n', '<C-s>', 		':bel split | wincmd j | resize 8 | term<CR>')

-- Esc to exit terminal mode
vim.keymap.set('t', '<Esc>', 		'<C-\\><C-n>')

-- Goto previous/next diagnostic warning/error
vim.keymap.set('n', 'g[', 			vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set('n', 'g]', 			vim.diagnostic.goto_next, { silent = true })

vim.keymap.set('n', '<leader>e', 	':NvimTreeToggle<CR>')

vim.keymap.set('n', '<leader>gg', 	':Git<space>')
vim.keymap.set('n', '<leader>gs', 	':Git<CR>')
vim.keymap.set('n', '<leader>gc', 	':Git commit<CR>')
vim.keymap.set('n', '<leader>gd', 	':G diff<CR>')
vim.keymap.set('n', '<leader>ga', 	':G add<space>')
vim.keymap.set('n', '<leader>gp', 	':G push<CR>')
vim.keymap.set('n', '<leader>gP', 	':G pull<CR>')

vim.keymap.set('n', 'gl', 		    ':VimtexView<CR>')

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

