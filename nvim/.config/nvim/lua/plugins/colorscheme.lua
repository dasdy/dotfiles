return {
  { "catppuccin/nvim", lazy = true, name = "catppuccin" },
  { "rose-pine/neovim", lazy = true, name = "rose-pine" },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "folke/tokyonight.nvim", lazy = true, opts = { style = "moon" }, name = "tokyonight" },
  -- This line actually sets colorscheme to one of the above
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
}
