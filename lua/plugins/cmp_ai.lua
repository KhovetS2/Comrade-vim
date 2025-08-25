return {
	{
		"milanglacier/minuet-ai.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
		config = function()
			require("minuet").setup({
				-- MUITO IMPORTANTE: escolha FIM (copilot-like)
				provider = "openai_fim_compatible",
				n_completions = 1,
				context_window = 256, -- reduza se quiser poupar VRAM/tempo
				provider_options = {
					openai_fim_compatible = {
						name = "Ollama",
						end_point = "http://127.0.0.1:11434/v1/completions",
						model = "qwen2.5-coder:3b",
						api_key = "OLLAMA_DUMMY", -- nome da env var (precisa existir, qualquer valor)
						optional = {
							max_tokens = 32,
							temperature = 0.2,
							top_p = 0.9,
						},
					},
				},
			})

			-- fonte do minuet no nvim-cmp
			local cmp = require("cmp")
			cmp.setup({
				sources = vim.list_extend(
					{ { name = "minuet", group_index = 1, priority = 110 } },
					cmp.get_config().sources or {}
				),
				completion = {
					keyword_length = 2,
					autocomplete = {
						cmp.TriggerEvent.TextChanged,
						cmp.TriggerEvent.InsertEnter,
					},
				},
				performance = {
					debounce = 200,
					throttle = 60,
					fetching_timeout = 2000,
				},
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-@>"] = cmp.mapping.complete(), -- fallback
					["<C-S-Space>"] = cmp.mapping.complete(), -- fallback
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
				}),
			})
		end,
	},
}
