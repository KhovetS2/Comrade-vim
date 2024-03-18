return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		-- rebase always
		vim.keymap.set("n", "<leader>gp", function()
			vim.cmd.Git("push")
		end, {})
	end,
}
