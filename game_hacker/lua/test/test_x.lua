local thread_list = require "test.test_global"
local test_x  = {}

function test_x.add_one()
    thread_list.x = thread_list.x + 1
    thread_list.y = thread_list.x + 2
end

return test_x