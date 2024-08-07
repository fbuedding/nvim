require("fbuedding.remap")
require("fbuedding.set")


require('go').setup()

require("neo-tree.command").execute({ toggle = true, reveal = true, position = "current" })
-- Run gofmt + goimport on save

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = format_sync_grp,
})

vim.opt.mouse = ""
