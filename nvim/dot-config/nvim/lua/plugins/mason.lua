return {
  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "shfmt",
        "black",
        "codelldb",
        "debugpy",
        "delve",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "html-lsp",
        "htmx-lsp",
        "json-lsp",
        "prettier",
        "shellcheck",
        "stylua",
        "tailwindcss-language-server",
        "yaml-language-server",
      },
    },
  },
}
