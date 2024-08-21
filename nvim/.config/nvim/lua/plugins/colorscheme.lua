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
  { "rose-pine/neovim", name = "rose-pine" },
  { "ellisonleao/gruvbox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
