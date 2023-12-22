return {
	{
		"zbirenbaum/copilot.lua",
		cmd = { "Copilot" },
		event = { "InsertEnter" },
		lazy = false,

		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = false,
				},
				panel = {
					enabled = false,
				},
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")

			cmp.setup({
				sources = {
					{ name = "copilot", group_index = 2 },
				},
				mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          [";;"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
          -- close cmp 
          ["<M-j>"] = cmp.mapping.close(),
        })
			})
		end,
	},
}
