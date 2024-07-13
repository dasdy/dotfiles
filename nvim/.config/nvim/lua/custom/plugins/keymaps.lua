-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


vim.keymap.set('n', "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
vim.keymap.set({ 'i', 'n' }, "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
vim.keymap.set({ 'v', 'n' }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set({ 'v', 'n' }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
vim.keymap.set('n', "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh & Display Codelens" })

-- Buffer manipulation. Temp bindings until I get used to

vim.keymap.set('n', '<leader>bd', ":bdelete<CR>", { desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>bp', ":bprevious<CR>", { desc = '[B]uffer [P]rev' })
vim.keymap.set('n', '<leader>bn', ":bnext<CR>", { desc = '[B]uffer [N]ext' })

-- Open file explorer in-place
vim.keymap.set('n', '<leader>bv', ":Vex<CR>", { desc = '[B]rowser [V]ertical' })
vim.keymap.set('n', '<leader>bh', ":Sex<CR>", { desc = '[B]rowser [H]orizontal' })
vim.keymap.set('n', '<leader>be', ":Ex<CR>", { desc = '[B]rowser' })

-- Move in buffers
-- Conflicts with horizontal splits, should rething this
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

vim.keymap.set("n", "<A-l>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-h>", ":bprevious<CR>", { noremap = true, silent = true })


-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { noremap = true })
vim.keymap.set("v", ">", ">gv", { noremap = true })

-- Move lines
-- Note that on macOS this requires setting option key to work as "Esc+"
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
