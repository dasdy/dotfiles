return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- disable html formatter - it conflicts with templ
        templ = { "templ" },
      },
      default_format_opts = {
        timeout_ms = 10000,
        lsp_fallback = true,
      },
    },
  },
}
