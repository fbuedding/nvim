local port = os.getenv('GDScript_Port') or '6005'
local cmd = vim.lsp.rpc.connect('127.0.0.1', port)
local pipe = '/tmp/godot.pipe' -- I use /tmp/godot.pipe

vim.lsp.start({
  name = 'Godot',
  cmd = cmd,
  autostart = true,
  root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot' }, { upward = true })[1]),
  on_attach = function(client, bufnr)
    vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
  end
})
