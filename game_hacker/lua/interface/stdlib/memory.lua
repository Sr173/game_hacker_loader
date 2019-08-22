local memory = {}

local ffi = require "ffi"

ffi.cdef [[
    void* my_malloc(size_t size);
]]

memory.malloc = ffi.C.my_malloc

return memory