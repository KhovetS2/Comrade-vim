return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>fs", vim.cmd.Git)
		-- rebase always
		vim.keymap.set("n", "<leader>gP", function()
			vim.cmd.Git({ "pull", "--rebase" })
		end, {})
		vim.keymap.set("n", "<leader>gp", function()
			vim.cmd.Git("push")
		end, {})
	end,
}
