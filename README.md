# LazyVim-configuration

A minimal Neovim configuration using lazy.nvim for plugin management. This setup (from init.lua) sets the leader to "," and auto-installs lazy.nvim, then configures a compact set of plugins and sensible defaults.

Quick highlights
- Leader: "," (comma)
- Plugin manager: folke/lazy.nvim (auto-installed)
- Color scheme: navarasu/onedark.nvim
- Treesitter for syntax, highlighting and folding
- File tree: nvim-tree (toggle with <leader>e)
- Fuzzy finder: telescope (<leader>ff, <leader>fg, <leader>fb, <leader>fh)
- LSP & tooling: mason + mason-lspconfig (lua_ls, ts_ls, eslint, tailwindcss)
- Autocomplete: blink.cmp + friendly-snippets
- Auto pairs: nvim-autopairs
- Markdown preview, color picker, and small utilities

Defaults and behavior
- Numbers, relative numbers, termguicolors
- Tabs: 2 spaces for web/langs; 4 spaces for many compiled languages (filetype-specific autocmds)
- No swap/backup, persistent undo
- Treesitter-based folding (foldlevel=99 to start unfolded)
- C/C++ diagnostics disabled by filetype autocmd
- Transparent background + cursorline enabled

Install
1. Backup your existing Neovim config (if any).
2. Clone into your Neovim config folder:
   git clone https://github.com/DAKSie/LazyVim-configuration.git ~/.config/nvim
3. Open Neovim — lazy.nvim will be installed automatically and plugins loaded on first run.
4. Treesitter parsers can be updated with :TSUpdate. Mason will manage LSP servers.

Usage / Tips
- Toggle file explorer: <leader>e
- Telescope: <leader>ff (files), <leader>fg (live grep), <leader>fb (buffers), <leader>fh (help)
- Markdown preview: :MarkdownPreviewToggle

Thank you so much for using my Neovim configuration even if it's dog water, I hope you have a convenient time coding <3
