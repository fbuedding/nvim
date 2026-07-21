return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local conf = require("telescope.config").values
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			dap.adapters.coreclr = {
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
				args = { "--interpreter=vscode" },
			}

			local function find_csproj()
				local cwd = vim.fn.getcwd()
				local handle = io.popen("find " .. cwd .. " -name '*.csproj'")
				local result = handle:read("*a")
				handle:close()

				local projects = {}
				for line in string.gmatch(result, "[^\r\n]+") do
					table.insert(projects, line)
				end

				return projects
			end

			local function get_project_name(path)
				return path:match("([^/]+)%.csproj$")
			end

			local function get_launch_url(project_dir)
				local file = project_dir .. "/Properties/launchSettings.json"
				local f = io.open(file, "r")
				if not f then
					return nil
				end
				local content = f:read("*all")
				f:close()
				local url = content:match('"applicationUrl"%s*:%s*"([^"]+)"')
				if url then
					return url:match("([^;]+)")
				end
				return nil
			end

			local function pick_project(callback)
				local projects = find_csproj()
				if #projects == 0 then
					return
				end

				pickers
					.new({}, {
						prompt_title = "C# Projekt auswählen",
						finder = finders.new_table({
							results = projects,
							entry_maker = function(entry)
								return {
									value = entry,
									display = get_project_name(entry),
									ordinal = entry,
								}
							end,
						}),
						sorter = conf.generic_sorter({}),
						attach_mappings = function(prompt_bufnr)
							actions.select_default:replace(function()
								local selection = action_state.get_selected_entry()
								actions.close(prompt_bufnr)
								callback(selection.value)
							end)
							return true
						end,
					})
					:find()
			end

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "Launch C#",
					request = "launch",

					program = function()
						local co = coroutine.running()

						pick_project(function(csproj)
							local project_dir = csproj:match("(.+)/[^/]+%.csproj$")
							local dll_name = csproj:match("([^/]+)%.csproj$")

							local handle = io.popen(
								"find " .. project_dir .. "/bin/Debug -name '" .. dll_name .. ".dll' | head -n 1"
							)
							local result = handle:read("*a")
							handle:close()
							result = result:gsub("\n", "")

							if result == "" then
								os.execute("dotnet build " .. csproj)

								local handle2 = io.popen(
									"find " .. project_dir .. "/bin/Debug -name '" .. dll_name .. ".dll' | head -n 1"
								)
								result = handle2:read("*a")
								handle2:close()
								result = result:gsub("\n", "")
							end

							coroutine.resume(co, {
								dll = result,
								project_dir = project_dir,
							})
						end)

						local res = coroutine.yield()
						vim.g._dap_last = res
						return res.dll
					end,

					cwd = function()
						return vim.g._dap_last and vim.g._dap_last.project_dir or vim.fn.getcwd()
					end,

					env = function()
						local project_dir = vim.g._dap_last and vim.g._dap_last.project_dir
						local url = project_dir and get_launch_url(project_dir)
						return {
							ASPNETCORE_ENVIRONMENT = "Development",
							ASPNETCORE_URLS = url or "http://localhost:5000",
						}
					end,
				},
			}

			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "Error" })
			vim.fn.sign_define("DapStopped", { text = "▶", texthl = "WarningMsg", linehl = "Visual" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "x", texthl = "Error" })

			vim.keymap.set("n", "<F5>", dap.continue)
			vim.keymap.set("n", "<F6>", dap.step_over)
			vim.keymap.set("n", "<F7>", dap.step_into)
			vim.keymap.set("n", "<F8>", dap.step_out)
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)

			vim.keymap.set("n", "<leader>du", function()
				dapui.close()
			end)

			local maximized = false
			vim.keymap.set("n", "<leader>dm", function()
				if maximized then
					dapui.open()
					maximized = false
				else
					vim.cmd("wincmd o")
					maximized = true
				end
			end)

			vim.keymap.set("n", "<leader>ds", function()
				dapui.float_element("scopes", { enter = true })
			end)

			vim.keymap.set("n", "<leader>dr", function()
				dapui.float_element("repl", { enter = true })
			end)
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			dap.listeners.after.event_initialized["dapui"] = function()
				dapui.open()
			end

			dap.listeners.before.event_terminated["dapui"] = function()
				dapui.close()
			end

			dap.listeners.before.event_exited["dapui"] = function()
				dapui.close()
			end
		end,
	},
}
