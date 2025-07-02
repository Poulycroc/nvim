return {
	-- Autotags
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},

	-- comments
	{
		"numToStr/Comment.nvim",
		keys = {
			-- Built-in mappings (optional if you use <leader>/ instead)
			{ "gcc", mode = "n", desc = "Comment toggle current line" },
			{ "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
			{ "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
			{ "gbc", mode = "n", desc = "Comment toggle current block" },
			{ "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
			{ "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },

			-- 👇 Custom mapping: <leader>/ in normal mode
			{
				"<leader>/",
				mode = "n",
				desc = "Toggle comment (current line)",
				function()
					require("Comment.api").toggle.linewise.current()
				end,
			},

			-- 👇 Custom mapping: <leader>/ in visual mode
			{
				"<leader>/",
				mode = "x",
				desc = "Toggle comment (selected lines)",
				function()
					-- get the selected region
					local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
					vim.api.nvim_feedkeys(esc, "nx", false)

					local api = require("Comment.api")
					local vmode = vim.fn.visualmode()

					api.toggle.linewise(vmode)
				end,
			},
		},
		config = function(_, opts)
			require("Comment").setup(opts)
		end,
		lazy = false,
	},
	-- useful when there are embedded languages in certain types of files (e.g. Vue or React)
	{ "joosepalviste/nvim-ts-context-commentstring", lazy = true },

	-- Neovim plugin to improve the default vim.ui interfaces
	{
		"stevearc/dressing.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
		config = function()
			require("dressing").setup()
		end,
	},

	-- Neovim notifications and LSP progress messages
	{
		"j-hui/fidget.nvim",
	},

	-- find and replace
	{
		"windwp/nvim-spectre",
		enabled = true,
		event = "BufRead",
		keys = {
			{
				"<leader>Rr",
				function()
					require("spectre").open()
				end,
				desc = "Replace",
			},
			{
				"<leader>Rw",
				function()
					require("spectre").open_visual({ select_word = true })
				end,
				desc = "Replace Word",
			},
			{
				"<leader>Rf",
				function()
					require("spectre").open_file_search()
				end,
				desc = "Replace Buffer",
			},
		},
	},

	-- Heuristically set buffer options
	{
		"tpope/vim-sleuth",
	},

	{
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},

	-- editor config support
	{
		"editorconfig/editorconfig-vim",
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
    -- stylua: ignore
    keys = {
      { "zk",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "Zk",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
	},

	-- {
	--   "utilyre/barbecue.nvim",
	--   name = "barbecue",
	--   version = "*",
	--   dependencies = {
	--     "SmiteshP/nvim-navic",
	--     "nvim-tree/nvim-web-devicons", -- optional dependency
	--   },
	--   opts = {
	--     -- configurations go here
	--   },
	--   config = function()
	--     require("barbecue").setup({
	--       create_autocmd = false, -- prevent barbecue from updating itself automatically
	--     })
	--
	--     vim.api.nvim_create_autocmd({
	--       "WinScrolled", -- or WinResized on NVIM-v0.9 and higher
	--       "BufWinEnter",
	--       "CursorHold",
	--       "InsertLeave",
	--
	--       -- include this if you have set `show_modified` to `true`
	--       -- "BufModifiedSet",
	--     }, {
	--       group = vim.api.nvim_create_augroup("barbecue.updater", {}),
	--       callback = function()
	--         require("barbecue.ui").update()
	--       end,
	--     })
	--   end,
	-- },
	-- persist sessions
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {},
	},

	{
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup({
				mappings = {
					add = "za",
					delete = "zd",
					replace = "zr",
				},
			})

			require("mini.pairs").setup()

			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = vim.g.have_nerd_font })

			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},

	{
		"echasnovski/mini.icons",
		enabled = true,
		opts = {},
		lazy = true,
	},

	{
		"fladson/vim-kitty",
		"MunifTanjim/nui.nvim",
	},
	{
		"nvchad/showkeys",
		cmd = "ShowkeysToggle",
		opts = {
			timeout = 1,
			maxkeys = 6,
			-- bottom-left, bottom-right, bottom-center, top-left, top-right, top-center
			position = "bottom-right",
		},

		keys = {
			{
				"<leader>ut",
				function()
					vim.cmd("ShowkeysToggle")
				end,
				desc = "Show key presses",
			},
		},
	},
}
