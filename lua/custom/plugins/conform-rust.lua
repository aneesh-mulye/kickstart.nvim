return {
  {
    'stevearc/conform.nvim',
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.rust = { 'rustfmt' } -- :contentReference[oaicite:6]{index=6}
      -- optional, but nice for Cargo.toml:
      -- opts.formatters_by_ft.toml = { "taplo" }
    end,
  },
}
