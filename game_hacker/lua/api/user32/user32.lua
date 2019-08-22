local ffi = require "ffi"
local bit = require "bit"

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
    LRESULT DefWindowProcA(HWND hWnd,UINT Msg, WPARAM wParam, LPARAM lParam);
    BOOL ShowWindow(HWND hWnd, int nCmdShow);
    BOOL UpdateWindow(HWND hWnd);
    BOOL TranslateMessage(const void *lpMsg);
    LRESULT DispatchMessageA(const void *lpMsg);
    BOOL PeekMessageA(LPMSG lpMsg,HWND hWnd,UINT wMsgFilterMin,UINT wMsgFilterMax,UINT wRemoveMsg);
    BOOL GetMessageA(LPMSG lpMsg,HWND hWnd,UINT wMsgFilterMin,UINT wMsgFilterMax);
]]

user32. WS_OVERLAPPED =      0x00000000
user32. WS_POPUP        =    0x80000000
user32. WS_CHILD        =    0x40000000
user32. WS_MINIMIZE     =    0x20000000
user32. WS_VISIBLE       =   0x10000000
user32. WS_DISABLED      =   0x08000000
user32. WS_CLIPSIBLINGS  =   0x04000000
user32. WS_CLIPCHILDREN  =   0x02000000
user32. WS_MAXIMIZE      =   0x01000000
user32. WS_CAPTION      =    0x00C00000
user32. WS_BORDER       =    0x00800000
user32. WS_DLGFRAME     =    0x00400000
user32. WS_VSCROLL      =    0x00200000
user32. WS_HSCROLL      =    0x00100000
user32. WS_SYSMENU       =   0x00080000
user32. WS_THICKFRAME    =   0x00040000
user32. WS_GROUP         =   0x00020000
user32. WS_TABSTOP       =   0x00010000
user32. WS_MINIMIZEBOX       =   0x00020000
user32. WS_MAXIMIZEBOX       =   0x00010000


user32.WS_OVERLAPPEDWINDOW = bit.bor(user32.WS_OVERLAPPED,user32.WS_CAPTION,user32.WS_SYSMENU,user32.WS_THICKFRAME,user32.WS_MINIMIZEBOX,user32.WS_MAXIMIZEBOX)

user32.FindWindow = ffi.C.FindWindowA
user32.GetWindowTextA = ffi.C.GetWindowTextA
user32.GetClassNameA = ffi.C.GetClassNameA
user32.GetSystemMetrics = ffi.C.GetSystemMetrics
user32.GetWindowRect = ffi.C.GetWindowRect
user32.GetWindowThreadProcessId = ffi.C.GetWindowThreadProcessId
user32.MessageBox = ffi.C.MessageBoxA
user32.CreateWindowEx = ffi.C.CreateWindowExA
user32.RegisterClassEx = ffi.C.RegisterClassExA
user32.DefWindowProc = ffi.C.DefWindowProcA
user32.ShowWindow = ffi.C.ShowWindow
user32.UpdateWindow = ffi.C.UpdateWindow
user32.TranslateMessage = ffi.C.TranslateMessage
user32.DispatchMessage = ffi.C.DispatchMessageA
user32.PeekMessage = ffi.C.PeekMessageA
user32.GetMessage = ffi.C.GetMessageA

user32.PM_REMOVE = 1

return user32