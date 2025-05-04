return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      matcher = {
        frecency = true,
      },
      explorer = {
        layout = { preset = "select" },
        -- layout = {
        --   cycle = true,
        --   --- Use the default layout or vertical if the window is too narrow
        --   preset = function()
        --     return vim.o.columns >= 120 and "default" or "vertical"
        --   end,
        -- },
      },
    },
  },

  keys = {
    {
      "<leader>fe",
      function()
        Snacks.explorer({ cwd = LazyVim.root(), layout = { preset = "select" }, auto_close = true })
      end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>fE",
      function()
        Snacks.explorer({ layout = { preset = "vscode" }, auto_close = true })
      end,
      desc = "Explorer Snacks (cwd)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
    { "<leader>E", "<leader>fE", desc = "Explorer Snacks (cwd)", remap = true },
  },
}
