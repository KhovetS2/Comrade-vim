-- "gc" to comment visual regions/lines
return {
	"numToStr/Comment.nvim",
	lazy = false,
	config = function()
		require("Comment").setup()
		vim.keymap.set("n", "<leader>lc", function()
			require("Comment.api").toggle.linewise.current()
		end, { silent = true, desc = "Comment line" })
	end,
}

-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following lua:
--    require('gitsigns').setup({ ... }):iiiiiiu
-- See `:help gitsigns` to understand what the configuration keys do
