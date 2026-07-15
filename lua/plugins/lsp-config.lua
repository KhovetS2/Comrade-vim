return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = {
				"ts_ls",
				"eslint",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"rust_analyzer",
				"pyright",
				"volar",
			},
			automatic_installation = true,
			automatic_enable = {
				exclude = { "rust_analyzer" },
			},
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

		-- Apply capabilities to all servers globally
		vim.lsp.config("*", { capabilities = capabilities })

		-- Keymaps via LspAttach (replaces on_attach)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-keymaps", { clear = true }),
			callback = function(ev)
				local bufnr = ev.buf
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

				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client and client.name == "rust-analyzer" then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
			end,
		})

		-- Rust: configurado via rustaceanvim (lua/plugins/rust.lua)

		-- TypeScript + Vue
		local data_path = vim.fn.stdpath("data")
		local vue_lang_path = data_path .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

		vim.lsp.config("ts_ls", {
			init_options = {
				plugins = {
					{
						name = "@vue/typescript-plugin",
						location = vue_lang_path,
						languages = { "vue" },
					},
				},
			},
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
		})
	end,
}
