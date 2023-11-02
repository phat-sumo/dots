require 'nvim-treesitter.configs'.setup { 
	ensure_installed = {
		"c",
		"cpp",
		"lua",
		"python",
		"bash",
		"fennel",
		"javascript",
		"typescript",
		"sxhkdrc",
		"svelte",
		"html",
		"css",
		"json",
	},

	autotag = {
		enable = true,
	},

	-- install parsers synchronously from the above list
	sync_install = false,

	-- if we're missing a parser, install it when entering the buffer
	auto_install = false,

	highlight = {
		enable = true,

		disable = {
			"c",
			"cpp",
			"lua",
			"python",
			"bash",
			"fennel",
			"javascript",
			"typescript",
		},
	}
}

if require("nvim-treesitter.parsers").has_parser "svelte" then
	local hi_query = [[
		(tag_name) @tag
		(erroneous_end_tag_name) @error
		(comment) @comment
		(attribute_name) @tag.attribute
		(attribute
			(quoted_attribute_value) @string)
		(text) @text @spell

		((element (start_tag (tag_name) @_tag) (text) @text.title)
		(#match? @_tag "^(h[0-9]|title)$"))

		((element (start_tag (tag_name) @_tag) (text) @text.strong)
		(#match? @_tag "^(strong|b)$"))

		((element (start_tag (tag_name) @_tag) (text) @text.emphasis)
		(#match? @_tag "^(em|i)$"))

		((element (start_tag (tag_name) @_tag) (text) @text.strike)
		(#match? @_tag "^(s|del)$"))

		((element (start_tag (tag_name) @_tag) (text) @text.underline)
		(#eq? @_tag "u"))

		((element (start_tag (tag_name) @_tag) (text) @text.literal)
		(#match? @_tag "^(code|kbd)$"))


		[
		"<"
		">"
		"</"
		"/>"
		] @tag.delimiter

		"=" @operator
  ]]

	require("vim.treesitter.query").set("svelte", "highlights", hi_query)
end
