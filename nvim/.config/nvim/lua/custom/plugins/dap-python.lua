return {
    'mfussenegger/nvim-dap-python',
    dependencies = { 'mfussenegger/nvim-dap', },
    ft = 'python',
    config = function(_, opts)
        -- Note: Mason will autoinstall this if debugpy is in the list of required things.
        -- And it will use globally available python to make a virtualenv for it
        local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
        require("dap-python").setup(path)
    end,
}
