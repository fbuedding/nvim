function TexFocusVim()
	--vim.api.nvim_command('silent execute "!open -a Alacritty"')
	vim.cmd("redraw")
end
local vimtex = vim.api.nvim_create_augroup("vimtex_event_focus", { clear = true })
vim.api.nvim_create_autocmd({ "User" }, {
	pattern = { "VimtexEventViewReverse", "VimtexEventView" },
	group = vimtex,
	callback = TexFocusVim,
})
