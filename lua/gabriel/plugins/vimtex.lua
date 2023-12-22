return {
	"lervag/vimtex",
	event = "BufRead",
	config = function()
		vim.g.vimtex_view_method = "zathura"
	end,
	keys = {
		{
			"<leader>ll",
			"<cmd>VimtexCompile<cr>",
			desc = "Compile LaTeX",
		},
		{
			"<leader>lv",
			"<cmd>VimtexView<cr>",
			desc = "View PDF",
		},
	},
}
