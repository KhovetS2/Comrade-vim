return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		-- 1) Inicia o Mason
		require("mason").setup()

		-- 2) Configura o mason-lspconfig
		require("mason-lspconfig").setup({
			ensure_installed = {
				"pyright",
				"ts_ls", -- TypeScript (substitui tsserver)
				"eslint",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"vue_ls", -- Vue (vue-language-server)
			},
			automatic_installation = true,
			automatic_enable = false, -- desativa o vim.lsp.enable() interno
		})

		-- 3) Capacidades para nvim-cmp
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- 4) on_attach com seus atalhos
		local on_attach = function(_, bufnr)
			local nmap = function(keys, fn, desc)
				vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = "LSP: " .. desc })
			end

			nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
			nmap("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
			nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
			nmap("<leader>D", vim.lsp.buf.type_definition, "[T]ype Definition")
			nmap("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
			nmap("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbols")
			nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
			nmap("K", vim.lsp.buf.hover, "Hover Documentation")
			nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
		end

		local lspconfig = require("lspconfig")

		-- 5) Caminho padrão onde o Mason instala o @vue/language-server
		local data_path = vim.fn.stdpath("data")
		local vue_lang_path = data_path .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

		-- 6) Configura o ts_ls para dar suporte também a .vue
		lspconfig.ts_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = vue_lang_path,
						languages = { "vue" },
					},
				},
			},
			filetypes = {
				"typescript",
				"javascript",
				"javascriptreact",
				"typescriptreact",
				"vue",
			},
		})

		-- 7) Configura o vue_ls (vue-language-server) para Vue puro
		lspconfig.volar.setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})

		-- 8) Demais servidores sem configuração extra
		for _, srv in ipairs({ "pyright", "eslint", "cssls", "tailwindcss", "lua_ls" }) do
			lspconfig[srv].setup({ on_attach = on_attach, capabilities = capabilities })
		end
	end,
}
