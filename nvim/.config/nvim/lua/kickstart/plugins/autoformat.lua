-- autoformat.lua
--
-- Use your language server to automatically format your code on save.
-- Adds additional commands as well to manage the behavior

return { -- Autoformat
	'stevearc/conform.nvim',
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			-- lua = { 'stylua' },
			-- Conform can also run multiple formatters sequentially
			go = { "goimports", "gofmt" },
			python = { 'black' },
			--
			-- You can use a sub-list to tell conform to run *until* a formatter
			-- is found.
			-- javascript = { { 'prettierd', 'prettier' } },
		},
		formatters = {
			black = {
				prepend_args = { "-S", "-l", "120" }
			}
		}
	},
}
