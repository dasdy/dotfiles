return {
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    -- branch = "regexp",
    ft = "python",
    opts = {
      options = {},
      settings = {
        -- options = {
        --   notify_user_on_activate = true,
        --   pyenv_path = "~/.local/share/pyenv/versions",
        -- },
        -- search = {
        --   my_venvs = {
        --     command = "fd '/bin/python$' ~/.local/share/pyenv/versions /opt/homebrew/Caskroom/miniforge/base/envs --full-path --color never -E pkgs/ -E envs/ -L",
        --   },
        -- },
      },
    },

    enabled = true,
  },
}
