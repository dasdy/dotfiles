return {
  { "catppuccin/nvim", lazy = true, name = "catppuccin" },
  -- rose pine has too much italics by default and no way to configure them granularly :(
  { "rose-pine/neovim", lazy = true, name = "rose-pine", opts = { styles = { italic = false } } },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "folke/tokyonight.nvim", lazy = true, opts = { style = "moon" }, name = "tokyonight" },
  -- This line actually sets colorscheme to one of the above
  { "LazyVim/LazyVim", opts = { colorscheme = "rose-pine" } },
  -- { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
}
