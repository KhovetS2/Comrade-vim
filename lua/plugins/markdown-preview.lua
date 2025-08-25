return {
	"iamcco/markdown-preview.nvim",
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	config = function()
		vim.g.mkdp_browser = "firefox" -- ou "firefox" se WSLg
		vim.g.mkdp_open_ip = "127.0.0.1"
		vim.g.mkdp_open_to_the_world = 0
		vim.g.mkdp_auto_start = 0
	end,
}
