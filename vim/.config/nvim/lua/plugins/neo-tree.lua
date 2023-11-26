return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      filesystem = {
        show_hidden = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_by_name = {
            ".DS_Store",
            ".git",
            "thumbs.db",
          },
        },
      },
    },
    keys = {
      {
        "<leader>e",
        "<cmd>Neotree toggle<cr>",
        desc = "Toggle Explorer",
      },
      {
        "<leader>o",
        function()
          if vim.bo.filetype == "neo-tree" then
            vim.cmd.wincmd("p")
          else
            vim.cmd.Neotree("focus")
          end
        end,
        desc = "Toggle Explorer Focus",
      },
    },
  },
}
