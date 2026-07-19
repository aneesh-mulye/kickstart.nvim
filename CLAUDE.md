# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal Neovim configuration based on kickstart.nvim, managed with lazy.nvim. There is no build or test suite; validation is done by launching Neovim.

## Commands

- Format Lua: `stylua .` — stylua is Mason-installed and not on PATH; use `~/.local/share/nvim/mason/bin/stylua`. (Config in `.stylua.toml`: 160-column width, single quotes, `call_parentheses = "None"`, `collapse_simple_statement = "Always"` — match this style when writing Lua)
- Check formatting: `~/.local/share/nvim/mason/bin/stylua --check .`
- Verify the config loads without errors: `nvim --headless "+qa"` (startup errors print to stderr)
- Plugin management happens inside Neovim: `:Lazy` (status), `:Lazy update`; `:Mason` for LSP/tool installs; `:checkhealth` for diagnostics. `lazy-lock.json` pins plugin versions.

## Architecture

- `init.lua` — nearly everything lives here: options, keymaps, autocommands, and the lazy.nvim setup with most plugin specs inline (telescope, nvim-lspconfig/Mason, conform, blink.cmp, treesitter, mini.nvim, colorscheme). LSP servers are declared in the `servers` table inside the nvim-lspconfig spec; entries there are auto-installed by Mason and enabled via `vim.lsp.config`/`vim.lsp.enable`.
- `lua/custom/plugins/*.lua` — every file in this directory is auto-imported as a plugin spec via `{ import = 'custom.plugins' }`. This is where personal additions go, not init.lua. A spec here can also *extend* an inline spec from init.lua by re-declaring the plugin with `opts = function(_, opts)` (see `conform-rust.lua`, which adds rustfmt to conform's `formatters_by_ft`).
- `lua/kickstart/plugins/` — optional stock kickstart modules; only `debug` and `neo-tree` are currently enabled (required near the bottom of init.lua).
- `after/ftplugin/<ft>.lua` — filetype-local keymaps (e.g. `rust.lua` maps K, `<leader>ca/rr/rt` to `:RustLsp` commands).

## Language-specific setup worth knowing

- **Rust** is handled by rustaceanvim (`lua/custom/plugins/rust.lua`), *not* by the `servers` table — `rust_analyzer` is deliberately commented out there. rust-analyzer runs clippy on save.
- **OCaml**: `ocamllsp` is launched via `dune exec ocamllsp` to use the opam-environment binary rather than Mason's. The iron.nvim REPL config auto-appends `;;` when sending lines to utop.
- **Clojure/Fennel/Python**: Conjure provides an interactive environment; its completions reach blink.cmp through blink.compat wrapping the nvim-cmp source `cmp-conjure` (enabled per-filetype in the blink.cmp spec).
- **Lua**: formatting by stylua only — `lua_ls` formatting is explicitly disabled. Conform's format-on-save is off for all filetypes by default (opt in via `enabled_filetypes` in the conform spec); manual format is `<leader>f`.
