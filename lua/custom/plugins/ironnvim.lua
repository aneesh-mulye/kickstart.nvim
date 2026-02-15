return {
  'Vigemus/iron.nvim',
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
              if not last_line:match ';;%s*$' then
                lines[#lines] = last_line .. ';;'
              end

              -- 3. Return the wrapped text
              return common.bracketed_paste(lines)
            end,
          },
        },
      },

      -- Keybindings
      keymaps = {
        send_motion = '<leader>sc',
        visual_send = '<leader>sc',
        send_file = '<leader>sf',
        send_line = '<leader>sl',
      },
    }
  end,
}
