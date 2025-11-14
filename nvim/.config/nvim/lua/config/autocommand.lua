local configFiles = vim.api.nvim_create_augroup("configFiles", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*/polybar/config",
	command = "call system('$XDG_CONFIG_HOME/polybar/launch.sh')",
	group = configFiles,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*/i3/config",
	command = "call system('i3 restart')",
	group = configFiles,
})

vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		vim.diagnostic.open_float(
			nil,
			{ close_events = { "BufLeave", "CursorMoved", "InsertEnter" }, focusable = false, scope = "cursor" }
		)
	end,
})

local vimtexConfig = vim.api.nvim_create_augroup("vimtexConfig", {})
vim.api.nvim_create_autocmd("User", {
	pattern = "VimtexEventQuit",
	command = "call vimtex#compiler#clean(0)",
	group = vimtexConfig,
})

-- Start terminal in insert mode
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	command = "startinsert",
})

-- Close term if exited with 0
vim.api.nvim_create_autocmd({ "TermClose" }, {
	desc = "Automatically close terminal buffers when started with no arguments and exiting without an error",
	callback = function(args)
		if vim.v.event.status == 0 then
			local info = vim.api.nvim_get_chan_info(vim.bo[args.buf].channel)
			local argv = info.argv or {}
			if #argv == 1 and argv[1] == vim.o.shell then
				vim.cmd({ cmd = "bdelete", args = { args.buf }, bang = true })
			end
		end
	end,
})

-- Close quickfixlist on buffer close
vim.api.nvim_create_augroup("qfClose", {})
vim.api.nvim_create_autocmd("WinEnter", {
	pattern = "*",
	command = "if winnr('$') == 1 && &buftype == 'quickfix'|q|endif",
})
