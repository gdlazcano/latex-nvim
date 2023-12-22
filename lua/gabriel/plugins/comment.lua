
return {
	"numToStr/Comment.nvim",
	event = "BufRead",
	config = function()
		require("Comment").setup({
		})
		vim.keymap.set("n", "<leader>/", function()
			require("Comment.api").toggle.linewise.current()
		end)
		vim.keymap.set(
			"v",
			"<leader>/",
			"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>"
		)
	end,
}
