local string = string
local io = io
local concat = table.concat

module(...)

-- Convert any binary string to hex
function tohex(str)
    return (str:gsub('.', function(c)
        return string.format('%02x', string.byte(c))
    end))
end

-- This is random string generator generating SHA1 compatible strings
function random_sha1()
    local ur = io.open("/dev/urandom", "r")
    local random_bin = ur:read(20) -- loads 160 bits
    ur:close()
    return tohex(random_bin) -- returns 40 hexadecimal characters
end

function get_file_name(basedir, id)
    local lower_id = id:lower()
    return concat({ basedir, lower_id:sub(1, 2), lower_id:sub(3, 4), id }, "/")
end

function fsize(file_path)
    local file = io.open(file_path, 'r')
    local current = file:seek() -- get current position
    local size = file:seek("end") -- get file size
    file:seek("set", current) -- restore position
    file:close()
    return size
end