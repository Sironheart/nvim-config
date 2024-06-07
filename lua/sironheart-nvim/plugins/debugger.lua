local dap = require("dap")
local dapui = require("dapui")

-- dap ui configuration
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

-- dap virtual text
require("nvim-dap-virtual-text").setup()

-- dap go adapter
require("dap-go").setup()
