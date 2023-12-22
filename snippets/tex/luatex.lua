local ls = require("luasnip")
local s = ls.snippet
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local helpers = require("gabriel.luasnip-helper-funcs")

local get_visual = helpers.get_visual

-- Return snippet tables
return {
	-- tex.sprint
	s(
		{ trig = "tpp", snippetType = "autosnippet" },
		fmta(
			[[
        tex.sprint(<>)
      ]],
			{
				d(1, get_visual),
			}
		)
	),
}
