-- Set leader key early to ensure it's available
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Install lazy.nvim if not already installed
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

-- Configure plugins
require("lazy").setup({
    -- Tokyo Night color scheme
	{
	    "navarasu/onedark.nvim",
	    lazy = false,
	    priority = 1000,
	    config = function()
		require("onedark").setup({
		    -- Add your configuration options here if needed
		    style = 'dark', -- Options: 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'
		    transparent = false, -- Enable transparent background
		    term_colors = true, -- Enable terminal colors
		    ending_tildes = false, -- Show end of buffer tildes
		    cmp_itemkind_reverse = false, -- Reverse item kind highlights in cmp

		    -- Custom highlights
		    colors = {}, -- Override default colors
		    highlights = {}, -- Override highlight groups

		    -- Plugins Config
		    diagnostics = {
			darker = true, -- darker colors for diagnostic
			undercurl = true, -- use undercurl for diagnostics
			background = true, -- use background color for virtual text
		    },
		})
		vim.cmd("colorscheme onedark")
	    end,
	},
    -- Mark down preivew
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    -- nvim-treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                -- Enable syntax highlighting
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                -- Enable indentation
                indent = {
                    enable = true,
                },
                -- Ensure these parsers are installed
                ensure_installed = {
                    "javascript",
                    "typescript",
                    "html",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "json",
                    "css",
                },
                -- Autoinstall languages that are not installed
                auto_install = true,
                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,
            })
        end,
    },
    -- File Tree
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        keys = { {"<leader>e", "<cmd>NvimTreeToggle<cr>"} },
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },
    -- Telescope
    {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require("telescope.builtin")

        -- Example keymaps
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end,
    },

    -- Mason

    {
	    "williamboman/mason.nvim",
	    dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
	    },

        opts = {
            servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                },
                ts_ls = {},
                eslint = {},
                tailwindcss = {},
            },
        },
	    config = function(_, opts)
		require("mason").setup()

		require("mason-lspconfig").setup({
		    ensure_installed = {"lua_ls", "eslint", "ts_ls"}
		})
            for server, config in pairs(opts.servers) do
                vim.lsp.config(server, config)
                vim.lsp.enable(server)
            end

            vim.diagnostic.config({
                virtual_text = true,
                -- virtual_lines = true,
                underline = true
            })
	    end
    },
    -- Blink Auto Complete
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            keymap = { preset = 'default' },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
        },
    },
    -- Auto Pairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
    -- Color Picker easycolor.nvim
    {
        "neph-iap/easycolor.nvim",
        dependencies = { "stevearc/dressing.nvim" }, -- Optional, but provides better UI for editing the formatting template
        opts = {},
        keys = { { "<leader>b", "<cmd>EasyColor<cr>", desc = "Color Picker" } }
    }
})

-- Basic Neovim settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

-- Treesitter specific settings (optional but recommended)
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- Basic Neovim settings (your existing settings)
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Filetype-specific indentation
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact", "css", "html", "json", "yaml", "lua", "markdown" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "cpp", "c", "java", "go", "rust", "php", "sh", "zsh" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- Fallback for all other filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    if vim.bo.shiftwidth == 0 then -- Only set if not already set
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.softtabstop = 4
    end
  end,
})



-- Disable diagnostics for C/C++ filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        -- Disable diagnostic features for C/C++
        vim.diagnostic.config({
            virtual_text = false,
            signs = false,
            underline = false,
        }, vim.api.nvim_get_current_buf())
        
        -- Alternatively, disable all diagnostics for current buffer
        vim.diagnostic.disable()
    end,
})

-- Re-enable diagnostics for other filetypes if needed
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "javascript", "typescript", "python" },
    callback = function()
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
        })
        vim.diagnostic.enable()
    end,
})

-- Create augroup for transparent background
vim.cmd([[
  augroup TransparentBG
    autocmd!
  augroup END
]])

-- Apply transparent background immediately
local highlight_groups = {
  "Normal", "NormalNC", "SignColumn", "EndOfBuffer", "LineNr", 
  "CursorLineNr", "NonText", "NormalFloat", "FloatBorder", 
  "Pmenu", "PmenuSel", "CursorColumn", "ColorColumn", "VertSplit"
}

for _, group in ipairs(highlight_groups) do
  vim.cmd("silent! hi " .. group .. " ctermbg=NONE guibg=NONE")
end

-- Make current line transparent and enable cursorline
vim.opt.cursorline = true
vim.cmd("silent! hi CursorLine ctermbg=NONE guibg=NONE")

-- Re-apply whenever a colorscheme loads
for _, group in ipairs(highlight_groups) do
  vim.cmd("autocmd TransparentBG ColorScheme * silent! hi " .. group .. " ctermbg=NONE guibg=NONE")
end

-- Make sure CursorLine stays transparent after ColorScheme
vim.cmd([[
  autocmd TransparentBG ColorScheme * set cursorline
  autocmd TransparentBG ColorScheme * silent! hi CursorLine ctermbg=NONE guibg=NONE
]])
