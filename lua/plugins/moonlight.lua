return {
	"shaunsingh/moonlight.nvim",
	name = "moonlight",
	priority = 1000,
	config = function()
		require("moonlight").set()
		vim.cmd.colorscheme = moonlight
	end,
}
