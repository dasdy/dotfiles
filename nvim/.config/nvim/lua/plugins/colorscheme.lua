return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      mason = true,
      neotree = true,
      neotest = true,
      which_key = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
