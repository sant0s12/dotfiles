local function nvim_tree_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", ".", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "q", api.tree.close, opts("Close"))
	vim.keymap.set("n", "n", api.fs.create, opts("Create"))
	vim.keymap.set("n", "dD", api.fs.remove, opts("Delete"))
	vim.keymap.set("n", "dT", api.fs.trash, opts("Trash"))
	vim.keymap.set("n", "a", api.fs.rename, opts("Rename"))
	vim.keymap.set("n", "dd", api.fs.cut, opts("Cut"))
	vim.keymap.set("n", "yy", api.fs.copy.node, opts("Copy"))
	vim.keymap.set("n", "yn", api.fs.copy.filename, opts("Copy Name"))
	vim.keymap.set("n", "yp", api.fs.copy.relative_path, opts("Copy Relative Path"))
	vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
	vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
	vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
	vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
end

return {
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			on_attach = nvim_tree_on_attach,
			view = {
				preserve_window_proportions = true,
				width = 25,
				adaptive_size = true,
			},
			trash = {
				cmd = "trash-put",
				require_confirm = true,
			},
			filters = {
				dotfiles = true,
			},
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			git = {
				ignore = false,
			},
		},
	},
}
