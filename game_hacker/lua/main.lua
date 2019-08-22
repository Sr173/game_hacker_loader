require "api.def"

local ffi = require "ffi"
local lanes = require "lanes"
local main_window = require "game.mainwindow"
local str_cov = require "interface.string.convert"
local imgui_impl = require "interface.imgui.impl"
local user32 = require "api.user32.user32"
local kernel32 = require "api.kernel32.kernel32"
local memory = require "interface.stdlib.memory"

--创建窗口和D3D设备
main_window.create(str_cov.utf8_2_gbk("牛逼"))
local result = imgui_impl.CreateDeviceD3D(main_window.hwnd)
if (result == 0) then
    user32.MessageBox(nil,str_cov.utf8_2_gbk("创建D3D设备失败"),str_cov.utf8_2_gbk("创建设备失败"),0)
end

user32.ShowWindow(main_window.hwnd,1)
user32.UpdateWindow(main_window.hwnd)

local msg = memory.malloc(ffi.sizeof("MSG"))

while (true) do
    if (user32.PeekMessage(msg,nil,0,0,user32.PM_REMOVE)) then
        user32.TranslateMessage(msg)
        user32.DispatchMessage(msg)
    end
end