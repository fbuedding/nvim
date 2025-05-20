local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Add to harpoon list" })
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Show harpoon quick menu" })

vim.keymap.set("n", "g1", function()
	harpoon:list():select(1)
end, { desc = "Go to harpoon tap 1" })
vim.keymap.set("n", "g2", function()
	harpoon:list():select(2)
end, { desc = "Go to harpoon tap 2" })
vim.keymap.set("n", "g3", function()
	harpoon:list():select(3)
end, { desc = "Go to harpoon tap 3" })
vim.keymap.set("n", "g4", function()
	harpoon:list():select(4)
end, { desc = "Go to harpoon tap 4" })

-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<C-S-P>", function()
-- 	harpoon:list():prev()
-- end)
-- vim.keymap.set("n", "<C-S-N>", function()
-- 	harpoon:list():next()
-- end)
