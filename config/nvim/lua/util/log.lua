local function log(msg)
    local home = os.getenv("HOME")
    local file = io.open(home .. '/nvim.log', "a")
    file:write(msg .. "\n")
    file:close()
end

return log
