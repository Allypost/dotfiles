return {
  {
    "numToStr/Comment.nvim",
    opts = {},
    keys = {
      {
        "<leader>/",
        function()
          require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
        end,
        desc = "Toggle comment line",
      },
      {
        "<leader>/",
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
        desc = "Toggle comment for selection",
        mode = "v",
      },
    },
    lazy = false,
  },
}
