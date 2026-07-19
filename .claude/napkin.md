# Napkin Runbook

## Curation Rules
- Re-prioritize on every read.
- Keep recurring, high-value notes only.
- Max 10 items per category.
- Each item includes date + "Do instead".

## Execution & Validation (Highest Priority)
1. **[2026-07-19] `stylua` is not on PATH despite CLAUDE.md saying `stylua .`**
   Do instead: run `~/.local/share/nvim/mason/bin/stylua --check .` (Mason-installed copy).
2. **[2026-07-19] Headless startup check misses runtime errors**
   Do instead: besides `nvim --headless "+qa"`, open a real file with deferred Lua (`vim.defer_fn`) and inspect `vim.lsp.get_clients()` / keymaps to catch attach-time issues.
3. **[2026-07-19] `:MasonUninstall` in headless mode throws a UI error but still uninstalls**
   Do instead: run it, ignore the stacktrace, and verify by listing `~/.local/share/nvim/mason/packages/`.

## Domain Behavior Guardrails
1. **[2026-07-19] lazy.nvim load order decides keymap winners**
   Do instead: remember `event = 'VimEnter'` plugins (telescope) set their maps AFTER startup plugins (iron.nvim), so later maps silently shadow earlier ones; check collisions with `nvim_get_keymap`.
2. **[2026-07-19] Any key in the `servers` table becomes a live LSP via `vim.lsp.enable`**
   Do instead: put formatter/tool installs in the `vim.list_extend(ensure_installed, {...})` block, never in `servers` (nvim-lspconfig ships configs for surprising names, e.g. `stylua --lsp`).
