return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		-- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{
				"nvim-tree/nvim-web-devicons",
				enabled = vim.g.have_nerd_font,
			},
			"folke/todo-comments.nvim",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
					},
				},
				-- pickers = {}
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			local map = vim.keymap.set

			map("n", "<leader>fc", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			map("n", "<leader>fb", builtin.buffers, { desc = "[ ] Find existing buffers" })
			map("n", "<leader>ff", builtin.find_files, { desc = "[S]earch [F]iles" })
			map("n", "<leader>fw", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			map("n", "<leader>ft", builtin.help_tags, { desc = "[S]earch [H]elp" })
			map(
				"n",
				"<leader>fz",
				"<cmd>Telescope current_buffer_fuzzy_find<CR>",
				{ desc = "Telescope Find in current buffer" }
			)

			map("n", "<leader>fgc", builtin.git_commits, { desc = "[S]earch [G]it [C]ommits" })

			map("n", "<leader>faa", "<cmd>Telescope marks<CR>", { desc = "[S]earch [M]arks" })

			-- Slightly advanced example of overriding default behavior and theme
			map("n", "<leader>fHH", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			map("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			map("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
}
