local ls = require("luasnip")
local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta
local d = ls.dynamic_node
local f = ls.function_node
local helpers = require("gabriel.luasnip-helper-funcs")
local get_visual = helpers.get_visual

-- A logical OR of `line_begin` and the regTrig '[^%a]trig'
function line_begin_or_non_letter(line_to_cursor, matched_trigger)
	local line_begin = line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
	local non_letter = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match("[^%a]")
	return line_begin or non_letter
end

-- Math context detection
local tex = {}
tex.in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
	return not tex.in_mathzone()
end

local line_begin = function(line_to_cursor, matched_trigger)
	-- +1 because `string.sub("abcd", 1, -2)` -> abc
	return line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
end

-- Return snippet tables
return {
	-- TYPEWRITER i.e. \texttt
	s(
		{
			trig = "([^%a])tt",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			priority = 2000,
			dscr = "Typewriter text",
		},
		fmta("<>\\texttt{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_text }
	),

	-- ITALIC i.e. \textit
	s(
		{ trig = "([^%a])tii", regTrig = true, wordTrig = false, snippetType = "autosnippet", dscr = "Italic text" },
		fmta("<>\\textit{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- BOLD i.e. \textbf
	s(
		{ trig = "tbb", snippetType = "autosnippet", dscr = "Bold text" },
		fmta("\\textbf{<>}", {
			d(1, get_visual),
		})
	),
	-- MATH ROMAN i.e. \mathrm
	s(
		{ trig = "([^%a])rmm", regTrig = true, wordTrig = false, snippetType = "autosnippet", dscr = "Math roman text" },
		fmta("<>\\mathrm{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATH CALIGRAPHY i.e. \mathcal
	s(
		{
			trig = "([^%a])mcc",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			dscr = "Math caligraphy text",
		},
		fmta("<>\\mathcal{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATH BOLDFACE i.e. \mathbf
	s(
		{ trig = "([^%a])mbf", regTrig = true, wordTrig = false, snippetType = "autosnippet", dscr = "Math bold text" },
		fmta("<>\\mathbf{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- MATH BLACKBOARD i.e. \mathbb
	s(
		{
			trig = "([^%a])mbb",
			regTrig = true,
			wordTrig = false,
			snippetType = "autosnippet",
			dscr = "Math blackboard text",
		},
		fmta("<>\\mathbb{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		})
	),
	-- REGULAR TEXT i.e. \text (in math environments)
	s(
		{ trig = "([^%a])tee", regTrig = true, wordTrig = false, snippetType = "autosnippet", dscr = "Regular text" },
		fmta("<>\\text{<>}", {
			f(function(_, snip)
				return snip.captures[1]
			end),
			d(1, get_visual),
		}),
		{ condition = tex.in_mathzone }
	),
}
