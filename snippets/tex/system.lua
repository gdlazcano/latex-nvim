local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local d = ls.dynamic_node

local helpers = require("gabriel.luasnip-helper-funcs")
local get_visual = helpers.get_visual

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Math context detection
local tex = {}
tex.in_mathzone = function()
	return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
	return not tex.in_mathzone()
end

-- Return snippet tables
return {
	-- Skeleton for a new LaTeX document
	s(
		{ trig = "!", dscr = "Skeleton for a new LaTeX document" },
		fmta(
			[[
      \documentclass[12pt]{article}
      \title{<>}
      \author{<>}
      \date{\today}
      \usepackage{amsmath}

      \begin{document}
        <>
      \end{document}
      ]],
			{
				i(1),
        i(2),
        i(3)
			}
		)
	),
	-- ANNOTATE (custom command for annotating equation derivations)
	s(
		{ trig = "ann", snippetType = "autosnippet", dscr = "\\annotate{}{}" },
		fmta(
			[[
      \annotate{<>}{<>}
      ]],
			{
				i(1),
				d(2, get_visual),
			}
		)
	),
	-- REFERENCE
	s(
		{ trig = " RR", snippetType = "autosnippet", wordTrig = false, dscr = "\\ref{}" },
		fmta(
			[[
      ~\ref{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- DOCUMENTCLASS
	s(
		{ trig = "dcc", snippetType = "autosnippet", dscr = "Document class" },
		fmta(
			[=[
        \documentclass[<>]{<>}
        ]=],
			{
				i(1, "a4paper"),
				i(2, "article"),
			}
		),
		{ condition = line_begin }
	),
	-- USE A LATEX PACKAGE
	s(
		{ trig = "pack", snippetType = "autosnippet" },
		fmta(
			[[
        \usepackage{<>}
        ]],
			{
				d(1, get_visual),
			}
		),
		{ condition = line_begin }
	),
	-- INPUT a LaTeX file
	s(
		{ trig = "inn", snippetType = "autosnippet" },
		fmta(
			[[
      \input{<><>}
      ]],
			{
				i(1, "~/dotfiles/config/latex/templates/"),
				i(2),
			}
		),
		{ condition = line_begin }
	),
	-- LABEL
	s(
		{ trig = "lbl", snippetType = "autosnippet" },
		fmta(
			[[
      \label{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	-- HPHANTOM
	s(
		{ trig = "hpp", snippetType = "autosnippet" },
		fmta(
			[[
      \hphantom{<>}
      ]],
			{
				d(1, get_visual),
			}
		)
	),
	s(
		{ trig = "TODOO", snippetType = "autosnippet" },
		fmta([[\TODO{<>}]], {
			d(1, get_visual),
		})
	),
	s(
		{ trig = "nc" },
		fmta([[\newcommand{<>}{<>}]], {
			i(1),
			i(2),
		}),
		{ condition = line_begin }
	),
	s(
		{ trig = "sii", snippetType = "autosnippet" },
		fmta([[\si{<>}]], {
			i(1),
		})
	),
	s(
		{ trig = "SI" },
		fmta([[\SI{<>}{<>}]], {
			i(1),
			i(2),
		})
	),
	-- URL
	s(
		{ trig = "url" },
		fmta([[\url{<>}]], {
			d(1, get_visual),
		})
	),
	-- href command with URL in visual selection
	s(
		{ trig = "LU", snippetType = "autosnippet" },
		fmta([[\href{<>}{<>}]], {
			d(1, get_visual),
			i(2),
		})
	),
	-- href command with text in visual selection
	s(
		{ trig = "LL", snippetType = "autosnippet" },
		fmta([[\href{<>}{<>}]], {
			i(1),
			d(2, get_visual),
		})
	),
	-- HSPACE
	s(
		{ trig = "hss", snippetType = "autosnippet" },
		fmta([[\hspace{<>}]], {
			d(1, get_visual),
		})
	),
	-- VSPACE
	s(
		{ trig = "vss", snippetType = "autosnippet" },
		fmta([[\vspace{<>}]], {
			d(1, get_visual),
		})
	),
	-- SECTION
	s(
		{ trig = "h1", snippetType = "autosnippet" },
		fmta([[\section{<>}]], {
			d(1, get_visual),
		})
	),
	-- SUBSECTION
	s(
		{ trig = "h2", snippetType = "autosnippet" },
		fmta([[\subsection{<>}]], {
			d(1, get_visual),
		})
	),
	-- SUBSUBSECTION
	s(
		{ trig = "h3", snippetType = "autosnippet" },
		fmta([[\subsubsection{<>}]], {
			d(1, get_visual),
		})
	),
}