require "api/user32/user32def"

local ffi = require "ffi"

local user32 = {}

ffi.cdef [[
    HWND FindWindowA(LPCSTR lpClassName,LPCSTR lpWindowName);
    int GetWindowTextA(HWND hWnd,LPSTR lpString, int nMaxCount);
    int GetClassNameA(HWND hWnd,LPSTR lpString, int nMaxCount);
    int GetSystemMetrics(int);
    bool GetWindowRect(HWND hWnd,LPRECT lpRect);
    bool GetWindowRect(HWND hWnd,LPRECT lpRect);
    DWORD GetWindowThreadProcessId(HWND hwnd,LPDWORD processid);
    int MessageBoxA(HWND hWnd,LPCSTR lpText,LPCSTR lpCaption,UINT uType);
    HWND CreateWindowExA( DWORD dwExStyle,LPCSTR lpClassName,LPCSTR lpWindowName,DWORD dwStyle,int X,int Y,int nWidth,int nHeight,HWND hWndParent,void* hMenu,void* hInstance,LPVOID lpParam);
    WORD RegisterClassExA(const WNDCLASSEXA*);
]]

user32.FindWindow = ffi.C.FindWindowA
user32.GetWindowTextA = ffi.C.GetWindowTextA
user32.GetClassNameA = ffi.C.GetClassNameA
user32.GetSystemMetrics = ffi.C.GetSystemMetrics
user32.GetWindowRect = ffi.C.GetWindowRect
user32.GetWindowThreadProcessId = ffi.C.GetWindowThreadProcessId
user32.MessageBox = ffi.C.MessageBoxA
user32.CreateWindowEx = ffi.C.CreateWindowExA
user32.RegisterClassEx = ffi.C.RegisterClassExA


return user32