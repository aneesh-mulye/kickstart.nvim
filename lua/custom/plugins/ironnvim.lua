return {
  'Vigemus/iron.nvim',
  cmd = { 'IronRepl', 'IronRestart', 'IronFocus', 'IronHide' },
  -- NOTE: keep these off the `<leader>s*` prefix — Telescope loads at VimEnter (after
  -- startup plugins) and silently shadows anything bound there.
  keys = {
    { '<leader>ic', mode = { 'n', 'v' }, desc = 'Iron: send motion/selection to REPL' },
    { '<leader>if', desc = 'Iron: send [F]ile to REPL' },
    { '<leader>il', desc = 'Iron: send [L]ine to REPL' },
  },
  config = function()
    local iron = require 'iron.core'
    local common = require 'iron.fts.common'

    iron.setup {
      config = {
        -- REPL Window settings
        scratch_repl = true,
        repl_open_cmd = require('iron.view').split.vertical.botright(40),

        -- The Vital Part: Defining how OCaml behaves
        repl_definition = {
          ocaml = {
            command = { 'utop' },
            format = function(lines)
              -- 1. Grab the last line
              local last_line = lines[#lines] or ''

              -- 2. Check if it ends with ;; (ignoring whitespace)
              --    The regex ';;%s*$' means ";;" followed by any amount of spaces at the end
              if not last_line:match ';;%s*$' then lines[#lines] = last_line .. ';;' end

              -- 3. Return the wrapped text
              return common.bracketed_paste(lines)
            end,
          },
        },
      },

      -- Keybindings
      keymaps = {
        send_motion = '<leader>ic',
        visual_send = '<leader>ic',
        send_file = '<leader>if',
        send_line = '<leader>il',
      },
    }
  end,
}
