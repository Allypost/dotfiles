local Util = require("lazyvim.util")

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>/", false },
      { "<leader>fl", Util.pick("live_grep"), desc = "Grep (Root Dir)" },
    },
  },
}
