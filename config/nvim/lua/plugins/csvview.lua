vim.api.nvim_create_autocmd("FileType", {
  pattern = { "csv", "tsv" },
  desc = "Automatically enable csvview for CSV and TSV files",
  callback = function()
    require("csvview").enable()
  end,
})

