return {
	{
		"benfowler/telescope-luasnip.nvim",
		module = "telescope._extensions.luasnip",
	},
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",

		event = "InsertEnter",

		config = function()
			local ls = require("luasnip")
			local types = require("luasnip.util.types")

			ls.config.set_config({
				enable_autosnippets = true,
				store_selection_keys = "<Tab>",
				ext_opts = {
					[types.choiceNode] = {
						active = {
							virt_text = { { "●", "StorageClass" } },
							hl_mode = "combine",
						},
					},
				},
			})

			require("luasnip.loaders.from_lua").load({ paths = "~/.config/latex-nvim/snippets/" })

			vim.keymap.set("i", "<Tab>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end)

      vim.keymap.set("i", "jj", function()
        if ls.jumpable(1) then
          ls.jump(1)
        end
      end, { silent = true })

			vim.keymap.set("i", "kk", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true })

			vim.keymap.set({ "i", "s" }, "<M-k>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,

		keys = {
      {
        "<leader>L",
        '<cmd>LuaSnipUnlinkCurrent<CR>',
        desc = "Unlink current snippets",
      }
		},
	},
}
