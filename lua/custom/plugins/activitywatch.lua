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
    -- Upstream's Client.__post builds its curl args without the `-X` flag, so curl
    -- parses the literal string 'POST' as a URL and every heartbeat fails. Replace it
    -- with a corrected copy until that's fixed upstream. This reaches into plugin
    -- internals, so bail out loudly if an update removes them.
    if not (aw.__private and aw.__private.aw) then
      vim.notify('aw-watcher.nvim internals changed; __post fix no longer applies — check upstream', vim.log.levels.WARN)
      return
    end
    local client = aw.__private.aw
    client.__post = function(self, url, data)
      local body = vim.fn.json_encode(data)
      local args = { '-X', 'POST', url, '-H', 'Content-Type: application/json', '--data-raw', body }
      local handle
      handle = vim.uv.spawn('curl', { args = args }, function(code)
        self.connected = code == 0
        if handle and not handle:is_closing() then handle:close() end
      end)
    end
  end,
}
