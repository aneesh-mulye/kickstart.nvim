return {
  {
    'mrcjkb/rustaceanvim',
    version = '^7', -- recommended
    lazy = false, -- recommended: plugin is already lazy internally
    init = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ['rust-analyzer'] = {
              -- Run cargo diagnostics on save (default is true)
              checkOnSave = true, -- :contentReference[oaicite:3]{index=3}

              -- Use clippy instead of cargo check
              check = {
                command = 'clippy', -- :contentReference[oaicite:4]{index=4}
              },

              -- Usually worth having on for real-world crates
              cargo = { buildScripts = { enable = true } },
              procMacro = { enable = true },
            },
          },
        },
      }
    end,
  },
}
