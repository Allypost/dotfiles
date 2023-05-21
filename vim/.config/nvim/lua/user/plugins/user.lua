-- TODO test

return {
	-- You can also add new plugins here as well:
	-- Add plugins, the lazy syntax
	-- "andweeb/presence.nvim",
	-- {
	--   "ray-x/lsp_signature.nvim",
	--   event = "BufRead",
	--   config = function()
	--     require("lsp_signature").setup()
	--   end,
	-- },
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		event = "User AstroFile",
		cmd = { "TodoQuickFix" },
	},
	{
		"lambdalisue/suda.vim",
		config = function()
			vim.g.suda_smart_edit = 1
		end,
		event = "User AstroFile",
	},
	{
		"ggandor/leap.nvim",
		dependencies = { "tpope/vim-repeat" },
		config = function()
			local leap = require("leap")
			-- Match Lightspeed styling
			vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
			vim.api.nvim_set_hl(0, "LeapMatch", {
				-- For light themes, set to 'black' or similar.
				fg = "white",
				bold = true,
				nocombine = true,
			})
			vim.api.nvim_set_hl(0, "LeapLabelPrimary", {
				fg = "red",
				bold = true,
				nocombine = true,
			})
			vim.api.nvim_set_hl(0, "LeapLabelSecondary", {
				fg = "blue",
				bold = true,
				nocombine = true,
			})
			leap.opts.highlight_unlabeled_phase_one_targets = true

			leap.leap({
				target_windows = { vim.fn.win_getid() },
			})
			leap.add_default_mappings(true)
		end,
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
			{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
		},
	},
	{
		"gbprod/cutlass.nvim",
		config = function()
			require("cutlass").setup({
				cut_key = "x",
				override_del = true,
				exclude = { "ns", "nS" },
			})
		end,
		event = "VeryLazy",
	},
}
