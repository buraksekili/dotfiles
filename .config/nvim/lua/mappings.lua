require "nvchad.mappings"

local map = vim.keymap.set
local bufnr = vim.api.nvim_get_current_buf()

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map(
  { "n", "v" },
  "<C-s>",
  function()
    vim.lsp.buf.format { async = true }
  end,
  {
    silent = true,
    desc = "code formatting with <C-s>",
  }
)

map("n", "K", function()
    vim.cmd.RustLsp({ "hover", "actions" })
  end,
  { silent = true, buffer = bufnr, desc = "Hover" }
)

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format { async = true }
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local mode = vim.api.nvim_get_mode().mode
    local filetype = vim.bo.filetype
    if vim.bo.modified == true and mode == 'n' and filetype ~= "oil" then
      vim.cmd('lua vim.lsp.buf.format()')
    end
    if (mode == 'n' or mode == "l") and filetype == "rs" then
      vim.cmd.RustLsp({ "renderDiagnostic" })
    end
  end
})

-- map("n", "<leader>rd", function()
-- 	vim.cmd.RustLsp({ "renderDiagnostic"})
-- end, { noremap = true, silent = true, buffer = bufnr, desc = "render diagnostics" })
