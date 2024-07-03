require("toggleterm").setup{
  open_mapping = [[<S-CR>]],
  insert_mappings = false, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_mode = false, -- if set to true (default) the previous terminal mode will be remembered
  direction = "vertical",
  shading_factor = '-1',

  size = function(term)
      if term.direction == "horizontal" then
        return 20
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.45
      end
    end,
}
