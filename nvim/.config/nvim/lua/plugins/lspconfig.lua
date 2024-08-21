return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- TODO figure out how to disable formatting. It does not conform to black config at all.
      ruff_lsp = { enabled = false },
      -- pyright = { enabled = false },
    },
  },
}
