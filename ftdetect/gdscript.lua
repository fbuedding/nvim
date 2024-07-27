local port = os.getenv('GDScript_Port') or '6006'
local cmd = vim.lsp.rpc.connect('127.0.0.1', port)
local pipe = '/tmp/godot.pipe' -- I use /tmp/godot.pipe

vim.lsp.start({
  name = 'Godot',
  cmd = cmd,
  root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
  on_attach = function(client, bufnr)
    print('serverstart("' .. pipe .. '")')
    vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
  end
})
