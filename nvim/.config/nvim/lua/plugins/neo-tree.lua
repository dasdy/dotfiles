return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    -- filesystem.window.position
    filesystem = {
      filtered_items = {
        visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          ".git",
        },
      },
      window = {
        position = "float",
      },
    },
  },
}
