local user32 = require "api/user32/user32"
local ffi = require "ffi"

local desktop_hwnd = user32.FindWindow("CabinetWClass","admin")

local text_buffer = ffi.new("char[260]")

user32.GetWindowTextA(desktop_hwnd,text_buffer,ffi.sizeof(text_buffer))

print ("Window Name:",ffi.string(text_buffer))

user32.GetClassNameA(desktop_hwnd,text_buffer,ffi.sizeof(text_buffer))

print ("Class Name:",ffi.string(text_buffer))

local rect = ffi.new("RECT[0]")

user32.GetWindowRect(desktop_hwnd, rect)

print ("left:",rect[0].left,",top:",rect[0].top)

local process_id = ffi.new("int[0]")

local thread_id = user32.GetWindowThreadProcessId(desktop_hwnd, process_id)

print ("thread_id:",thread_id,",process_id:",process_id[0])