return {
    
    {
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"cssls",
					"eslint",
					"tsserver",
					"pyright",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require("lspconfig")
			lspconfig.pyright.setup({
                capabilities = capabilities
            })
			lspconfig.tsserver.setup({
                capabilities = capabilities
            })
			lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
			lspconfig.eslint.setup({
                capabilities = capabilities
            })
			lspconfig.cssls.setup({
                capabilities = capabilities
            })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", function()
				vim.lsp.buf.definition()
			end, {})
			vim.keymap.set("n", "<leader>vca", function()
				vim.lsp.buf.code_action()
			end, {})
		end,
	},
}
