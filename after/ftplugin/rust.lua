-- after/ftplugin/rust.lua
local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set('n', 'K', function() vim.cmd.RustLsp { 'hover', 'actions' } end, { buffer = bufnr, silent = true })

vim.keymap.set('n', '<leader>ca', function()
  vim.cmd.RustLsp 'codeAction' -- grouped actions UI
end, { buffer = bufnr, silent = true })

vim.keymap.set('n', '<leader>rr', function() vim.cmd.RustLsp 'runnables' end, { buffer = bufnr, silent = true })

vim.keymap.set('n', '<leader>rt', function() vim.cmd.RustLsp 'testables' end, { buffer = bufnr, silent = true })
