return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
		},
		config = function()
			require("dapui").setup()
			require("dap-go").setup()

			require("dap").listeners.before.attach.dapui_config = function()
				require("dapui").open()
			end
			require("dap").listeners.before.launch.dapui_config = function()
				require("dapui").open()
			end
			require("dap").listeners.before.event_terminated.dapui_config = function()
				require("dapui").close()
			end
			require("dap").listeners.before.event_exited.dapui_config = function()
				require("dapui").close()
			end

			vim.keymap.set("n", "<leader>dc", function()
				require("dap").continue()
			end, { desc = "[D]ebugger [c]ontinue" })
			vim.keymap.set("n", "<leader>do", function()
				require("dap").step_over()
			end, { desc = "[D]ebugger step [o]ver" })
			vim.keymap.set("n", "<leader>di", function()
				require("dap").step_into()
			end, { desc = "[D]ebugger step [i]nto" })
			vim.keymap.set("n", "<leader>dO", function()
				require("dap").step_out()
			end, { desc = "[D]ebugger step [O]ut" })
			vim.keymap.set("n", "<leader>dt", function()
				require("dap").toggle_breakpoint()
			end, { desc = "[D]ebugger [T]oggle Breakpoint" })
			vim.keymap.set("n", "<leader>ds", function()
				require("dap").set_breakpoint()
			end, { desc = "[D]ebugger [s]et breakpoint" })
			vim.keymap.set("n", "<leader>dlp", function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, { desc = "[D]ebugger [l]og [point]" })
			vim.keymap.set("n", "<leader>dr", function()
				require("dap").repl.open()
			end, { desc = "[D]ebugger [r]epl" })
			vim.keymap.set("n", "<leader>dl", function()
				require("dap").run_last()
			end, { desc = "[D]ebugger [l]ast" })
			vim.keymap.set({ "n", "v" }, "<leader>dh", function()
				require("dap.ui.widgets").hover()
			end, { desc = "[D]ebugger UI [h]over" })
			vim.keymap.set({ "n", "v" }, "<leader>dp", function()
				require("dap.ui.widgets").preview()
			end, { desc = "[D]ebugger UI [p]review" })
			vim.keymap.set("n", "<leader>df", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end, { desc = "[D]ebugger [f]rames" })
			vim.keymap.set("n", "<leader>dS", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end, { desc = "[D]ebugger [S]copes" })
		end,
	},
}
