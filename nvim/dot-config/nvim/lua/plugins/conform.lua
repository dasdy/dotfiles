return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- disable html formatter - it conflicts with templ
        templ = { "templ" },
        python = { "ruff_format" },
        -- python = { "black" }, -- comment above, uncomment this to change python formatter
      },
      default_format_opts = {
        timeout_ms = 10000,
        lsp_fallback = true,
      },
    },
  },
}
