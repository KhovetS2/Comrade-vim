return {
	"theprimeagen/harpoon",
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")
		vim.keymap.set("n", "<leader>a", mark.add_file)
		vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

		-- Função para navegar até o arquivo com base no prefixo numérico
		local function nav_file_with_prefix()
			local file_number = vim.v.count
			if file_number == 0 then
				file_number = 1 -- Se nenhum prefixo for fornecido, padrão para 1
			end
			ui.nav_file(file_number)
		end

		-- Mapeia <leader>h para navegar até o arquivo com base no prefixo numérico
		vim.keymap.set("n", "<leader>h", nav_file_with_prefix, { noremap = true, silent = true })
	end,
}
