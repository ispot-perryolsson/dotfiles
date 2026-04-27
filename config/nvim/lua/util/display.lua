local function display(msg)
    -- 1. Create the buffer
    local buf = vim.api.nvim_create_buf(false, true)

    -- 2. Populate it with text
    local lines = { msg }
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- 3. Open it in the current window
    vim.api.nvim_set_current_buf(buf)
end

return display
