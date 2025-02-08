return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- disable html formatter - it conflicts with templ
        templ = { "templ" },
      },
    },
  },
}
