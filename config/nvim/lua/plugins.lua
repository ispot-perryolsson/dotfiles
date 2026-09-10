---@diagnostic disable: undefined-global
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
local theme_ok, theme = pcall(require, "plugins.theme")
if not theme_ok then
	-- Fallback to tokyonight if the theme symlink is missing
	theme = { { "olimorris/onedarkpro.nvim", lazy = false, priority = 1000, opts = { colorscheme = "onedark" } } }
end

local plugins = {
	"mfussenegger/nvim-dap",
    { 
        "mfussenegger/nvim-jdtls",
        dependencies = { "mfussenegger/nvim-dap" },
        ft = { "java" }
    },
    "williamboman/mason.nvim",
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "olimorris/onedarkpro.nvim", lazy = false, priority = 1000, opts = { colorscheme = "onedark" } },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		-- Disable the plugin's own <C-h/j/k/l> mappings; vim-herdr-navigation
		-- owns them and falls back to :TmuxNavigate* when $TMUX is set, so tmux
		-- keeps working while herdr panes get seamless navigation too.
		init = function()
			vim.g.tmux_navigator_no_mappings = 1
		end,
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		config = function()
			-- Single source of truth for <C-h/j/k/l> navigation (herdr + tmux fallback).
			dofile(vim.fn.expand("~/src/vim-herdr-navigation/editor/nvim.lua"))
		end,
	},
	"b3nj5m1n/kommentary",
	"rcarriga/nvim-dap-ui",
	"kyazdani42/nvim-web-devicons",
	"nvim-lua/plenary.nvim",
	"neovim/nvim-lspconfig",
    {
        'nvim-telescope/telescope.nvim', version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- optional but recommended
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    },
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"saadparwaiz1/cmp_luasnip",
	"L3MON4D3/LuaSnip",
    {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
      -- Optional dependencies
      dependencies = { { "nvim-mini/mini.icons", opts = {} } },
      -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
      -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
      lazy = false,
    },
    {
        'nvim-telescope/telescope.nvim', version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- optional but recommended
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        }
    },
	{ "nvim-neotest/nvim-nio" },
    {
        "rcasia/neotest-java",
        ft = "java",
        dependencies = {
            "mfussenegger/nvim-jdtls",
            "mfussenegger/nvim-dap", -- for debugging (optional)
            "rcarriga/nvim-dap-ui", -- recommended
            "theHamsta/nvim-dap-virtual-text", -- recommended
        },
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        }
    },
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"kyazdani42/nvim-web-devicons",
    {
    
      'nvim-treesitter/nvim-treesitter',
      lazy = false,
      build = ':TSUpdate',
      branch = 'main'
    },
	"wbthomason/packer.nvim",
	"lewis6991/gitsigns.nvim",
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"rouge8/neotest-rust",
			"nvim-neotest/neotest-vim-test",
			"nvim-neotest/neotest-plenary",
		},
	},
	{ "folke/neodev.nvim", opts = {} },
    --[[ {
        "3rd/image.nvim",
        build = false,
        opts = {
            processor = "magick_cli",
        }
    }, ]]
    --[[ {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            -- these are examples, not defaults. Please see the readme
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
        end,
    }, ]]
    {
      "supermaven-inc/supermaven-nvim",
      config = function()
        require("supermaven-nvim").setup({
          keymaps = {
            accept_suggestion = "<C-f>", -- or any other key
          },
        })
      end,
    },
    {
      "hat0uma/csvview.nvim",
      ---@module "csvview"
      ---@type CsvView.Options
      opts = {
        parser = { comments = { "#", "//" } },
        keymaps = {
          -- Text objects for selecting fields
          textobject_field_inner = { "if", mode = { "o", "x" } },
          textobject_field_outer = { "af", mode = { "o", "x" } },
          -- Excel-like navigation:
          -- Use <Tab> and <S-Tab> to move horizontally between fields.
          -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
          -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
          jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
          jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
          jump_next_row = { "<Enter>", mode = { "n", "v" } },
          jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
        },
      },
      cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    },
    {
      "OXY2DEV/markview.nvim",
      lazy = false,
    },
    {
        'numToStr/Comment.nvim',
        opts = {}
    },
    require("plugins.metals")
}
local all_themes = require('all-themes')
for i = 1, #all_themes do
    plugins[#plugins + 1] = all_themes[i]
end
require("lazy").setup(plugins)
local colorscheme
if #theme > 1 then
    colorscheme = theme[2]
else
    colorscheme = theme[1]
end
if colorscheme["opts"] ~= nil then
    vim.cmd("colorscheme " .. colorscheme["opts"]["colorscheme"])
end

require("Comment").setup()
