local kernel32 = require "api.kernel32.kernel32"
local ffi = require "ffi"
local bit = require "bit"

print ("GetTickCount:",kernel32.GetTickCount())

print ("GetCurrentProcess:",kernel32.GetCurrentProcess())

local current_dir = ffi.new("char[260]")

kernel32.GetCurrentDirectoryA(260,current_dir)

print ("GetCurrentDirectoryA:",ffi.string(current_dir))

print ("GetCurrentProcessId:",kernel32.GetCurrentProcessId())

local self_handle = kernel32.OpenProcess(kernel32.PROCESS_ALL_ACCESS,false,kernel32.GetCurrentProcessId()) 

print ("OpenProcess Current Process Handle:",self_handle)

print("CloseHandle", kernel32.CloseHandle(self_handle))
