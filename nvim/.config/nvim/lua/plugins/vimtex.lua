-- vim.g.vimtex_view_method = 'Okular'
-- vim.g.vimtex_quickfix_open_on_warning = 0

vim.g.vimtex_view_general_viewer = 'evince'

vim.g.vimtex_compiler_latexmk_engines = {
	['_']                = '-xelatex',
	['pdflatex']         = '-pdf',
	['dvipdfex']         = '-pdfdvi',
	['lualatex']         = '-lualatex',
	['xelatex']          = '-xelatex',
	['context (pdftex)'] = '-pdf -pdflatex=texexec',
	['context (luatex)'] = '-pdf -pdflatex=context',
	['context (xetex)']  = '-pdf -pdflatex=\'texexec --xtx\''
}

-- https://tex.stackexchange.com/a/725188
vim.g.vimtex_compiler_latexmk = {
	aux_dir = "aux", -- create a directory called aux that will contain all the auxiliary files
}
