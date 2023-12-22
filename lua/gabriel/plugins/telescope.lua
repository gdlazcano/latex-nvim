return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = false,

	config = function()
		local telescope = require("telescope")

		telescope.load_extension("luasnip")
		require("telescope").setup({
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            width = 0.9,
            height = 0.9,
            preview_height = 0.5,
          },
        },
      },
		})
	end,

	keys = {
		{
			"<leader>fl",
			"<cmd>Telescope luasnip theme=dropdown layout_config={'height':0.6,'width':0.9}<CR>",
			desc = "Find snippets",
		},
		{
			"<leader>ff",
			"<cmd>Telescope find_files<cr>",
			desc = "Find files",
		},
		{
			"<leader>fs",
			"<cmd>Telescope live_grep<cr>",
			desc = "Find string",
		},
	},
}
