return {
  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "black",
        "codelldb",
        "debugpy",
        "delve",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "flake8",
        "html-lsp",
        "htmx-lsp",
        "json-lsp",
        "prettier",
        "shellcheck",
        "shfmt",
        "stylua",
        "tailwindcss-language-server",
        "yaml-language-server",
      },
    },
  },
}
