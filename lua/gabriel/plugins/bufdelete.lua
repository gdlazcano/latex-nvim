return {
	"famiu/bufdelete.nvim",
	event = "BufRead",
	keys = {
		{
			"<C-c>",
			function()
				require("bufdelete").bufdelete(0, true)
			end,
			desc = "Delete buffer",
		},
		{
			"<C-x>",
			"<cmd>Bwipeout<CR>",
			desc = "Delete buffer and close window",
		},
	},
}
