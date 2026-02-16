-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Conjure
  {
    'Olical/conjure',
    ft = { 'clojure', 'fennel', 'python' }, -- etc
    lazy = true,
    init = function()
      -- Set configuration options here
      -- Uncomment this to get verbose logging to help diagnose internal Conjure issues
      -- This is VERY helpful when reporting an issue with the project
      -- vim.g['conjure#debug'] = true
      -- Hard-disable Rust client no matter what
      vim.g['conjure#filetype#rust'] = false
      vim.g['conjure#mapping#doc_word'] = '<localleader>k'
    end,
  },
  -- blink.cmp compatibility layer for nvim-cmp sources
  {
    'Saghen/blink.compat', -- lets Blink use nvim‑cmp sources
    version = '2.*', -- v2.x is for Blink v1.x
    lazy = true,
    opts = {}, -- mandatory so Lazy calls setup()
  },
  -- conjure completion source for nvim-cmp, to be used through above compat
  -- layer
  { 'PaterJason/cmp-conjure', lazy = true },
}
