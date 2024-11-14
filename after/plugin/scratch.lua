--require("scratch").setup({
--	-- your custom configuration
--})
vim.keymap.set("n", "<leader>bs", function()
	require("scratch").create({ filetype = "markdown" })
end)
