local ffi = require "ffi"

local convert = {}

ffi.cdef [[
    const char* gdpgztldsxwsndatt(const char* strUTF8);
]]

convert.utf8_2_gbk = ffi.C.gdpgztldsxwsndatt

return convert