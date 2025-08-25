return {
	-- 1) Ollama.nvim (chat/ações) — 100% local
	{
		"nomnivore/ollama.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		-- Comandos expostos pelo plugin
		cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
		-- Keymaps: use <c-u> para seleção visual ($sel)
		keys = {
			-- Menu de prompts (normal/visual)
			{
				"<leader>oo",
				":<c-u>lua require('ollama').prompt()<cr>",
				desc = "Ollama: menu de prompts",
				mode = { "n", "v" },
			},

			-- Explicar seleção (visual)
			{
				"<leader>oe",
				":<c-u>lua require('ollama').prompt('Explain_Selection')<cr>",
				desc = "Ollama: explicar seleção",
				mode = "v",
			},

			-- Refatorar seleção e substituir no buffer (visual)
			{
				"<leader>or",
				":<c-u>lua require('ollama').prompt('Refactor_Selection')<cr>",
				desc = "Ollama: refatorar seleção",
				mode = "v",
			},
		},

		---@type Ollama.Config
		opts = {
			-- endereço do daemon do Ollama local
			url = "http://127.0.0.1:11434",
			model = "codellama:7b", -- troque para o modelo que você já baixou

			-- NÃO subir o servidor automaticamente (você já tem um rodando)
			serve = {
				on_start = false,
				command = "ollama",
				args = { "serve" },
				stop_command = "pkill",
				stop_args = { "-SIGTERM", "ollama" },
			},

			-- Prompts nomeados (chamados por require('ollama').prompt('<nome>'))
			prompts = {
				-- mostra a resposta em janela flutuante
				Explain_Selection = {
					-- $sel => substituído pela seleção visual
					prompt = [[Explique de forma objetiva o seguinte trecho de código e a intenção do autor.
Liste também potenciais bugs e melhorias.

Trecho:
```$ftype
$sel
```]],
					action = "display",
					-- você pode definir um modelo específico aqui (senão usa o global):
					-- model = "codellama:7b",
					-- options = { temperature = 0.2 },
				},

				-- substitui a seleção pelo resultado (útil para refator)
				Refactor_Selection = {
					prompt = [[Reescreva o trecho abaixo de forma mais clara e idiomática, mantendo a lógica.
Retorne apenas o código entre crases no mesmo language block.

Trecho:
```$ftype
$sel
```]],
					-- extrai apenas o bloco ```<ftype> ... ```
					extract = "```$ftype\n(.-)```",
					action = "display_replace",
					-- options = { temperature = 0.1 },
				},
			},
		},
	},
}
