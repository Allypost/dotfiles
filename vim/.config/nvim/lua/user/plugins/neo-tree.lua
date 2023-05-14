return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = function(_, opts)
			opts.filesystem.filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_by_name = {
					".DS_Store",
					".git",
					"thumbs.db",
				},
			}
			opts.filesystem.show_hidden = true
		end,
	},
}
