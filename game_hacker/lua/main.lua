local user32 = require "api.user32.user32"
local lanes = require "lanes"
local thread_list = require "test.test_global"
local test_x = require "test.test_x"
local user32 = require "api.user32.user32"
local ffi = require "ffi"

local f = lanes.gen("*",
function ()
    local user32 = require "api/user32/user32"
    user32.MessageBox (nil,"111","111",0)
end
)

local wndclassexa = ffi.new("WNDCLASSEXA[0]")

print (tostring(ffi.typeof(wndclassexa)))

--f()

--user32.MessageBox (nil,"111","111",0)

local co2 = coroutine.create( 
    test_x.add_one
)

thread_list.x = 1

coroutine.resume(co2)

print (thread_list.x)
print (thread_list.y)

