local map = vim.keymap.set

--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map("n", "<leader>nh", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map(
	"v",
	"<leader>/",
	"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "Comment Toggle" }
)

map("n", "<tab>", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
map("n", "<S-tab>", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

-- Move in lines
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down + auto center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up + auto center" })
map("n", "n", "nzzzv", { desc = "Next search result + auto center" })
map("n", "N", "Nzzzv", { desc = "Previous search result + auto center" })

map("v", "<", "<gv", { noremap = true, silent = true, desc = "Decrease indent in visual selection" })
map("v", ">", ">gv", { noremap = true, silent = true, desc = "Increase indent in visual selection" })

map("n", "Q", "<nop>", { desc = "Disable Q" })
map("n", "f", "<nop>", { desc = "Disable default f" })
map("n", "x", '"_x', { desc = "Delete without yank" })
