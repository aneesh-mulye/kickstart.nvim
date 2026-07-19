return {
  'lowitea/aw-watcher.nvim',
  opts = {
    aw_server = {
      host = '127.0.0.1',
      port = 5600,
    },
  },
  config = function(_, opts)
    local aw = require 'aw_watcher'
    aw.setup(opts)
    local client = aw.__private.aw
    client.__post = function(self, url, data)
      local body = vim.fn.json_encode(data)
      local args = { '-X', 'POST', url, '-H', 'Content-Type: application/json', '--data-raw', body }
      local handle
      handle = vim.loop.spawn('curl', { args = args, verbatim = false }, function(code)
        self.connected = code == 0
        if handle and not handle:is_closing() then handle:close() end
      end)
    end
  end,
}
