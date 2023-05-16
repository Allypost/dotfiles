return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",

  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.vue" },
  { import = "astrocommunity.pack.prisma" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.python" },

  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity
  { import = "astrocommunity.colorscheme.catppuccin", enabled = true },
  {
    "catppuccin",
    opts = {
      flavor = "mocha",
    },
  },
  { import = "astrocommunity.colorscheme.nightfox", enabled = false },
  { import = "astrocommunity.colorscheme.oxocarbon", enabled = false },
  { import = "astrocommunity.colorscheme.tokyonight", enabled = false },
  { import = "astrocommunity.completion.copilot-lua-cmp" },
}
