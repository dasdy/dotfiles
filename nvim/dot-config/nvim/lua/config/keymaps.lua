-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "v", "n" }, "c", '"_c')
vim.keymap.set({ "v", "n" }, "C", '"_C')
vim.keymap.set("n", "<leader>d", '"_d', { desc = "Delete without changing clipboard" })
vim.keymap.set("v", "<leader>dd", '"_d', { desc = "Delete without changing clipboard" })
vim.keymap.set("n", "<leader>h", ":noh<CR>", { desc = "Stop highlighting local search" })
