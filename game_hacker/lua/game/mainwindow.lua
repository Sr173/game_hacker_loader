local main_window = {}
local ffi = require "ffi"
local user32 = require "api.user32.user32"
local kernel32 = require "api.kernel32.kernel32"

function main_window_wndproc(hwnd,message,wparam,lparam)
    print (message)
    return user32.DefWindowProc(hwnd,message,wparam,lparam)
end

main_window.hwnd = nil

function main_window.create(title)
    local wc = ffi.new("WNDCLASSEXA[0]")
    wc[0].cbSize = ffi.sizeof(wc[0])
    wc[0].style = 0x40
    wc[0].lpfnWndProc = ffi.cast("WNDPROC",main_window_wndproc)
    wc[0].cbClsExtra = 0
    wc[0].cbWndExtra = 0
    wc[0].hInstance = kernel32.GetModuleHandle(nil)
    wc[0].hIcon = nil
    wc[0].hCursor = nil
    wc[0].hbrBackground = nil
    wc[0].lpszMenuName = nil
    wc[0].lpszClassName = title
    wc[0].hIconSm = nil
    local retn = user32.RegisterClassEx(wc)
    main_window.hwnd = user32.CreateWindowEx(0,title,title,user32.WS_OVERLAPPEDWINDOW,100,100,1280,800,nil,nil, wc[0].hInstance,nil)
    return main_window.hwnd
end

return main_window