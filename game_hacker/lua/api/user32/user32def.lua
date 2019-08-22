local ffi = require"ffi"
require "api.common.windef"

local user32def = {}

ffi.cdef [[
    typedef void *HWND;
    typedef void *HHOOK;

    typedef LRESULT (* WNDPROC)(HWND, UINT, WPARAM, LPARAM);

    typedef struct tagWNDCLASSEXA {
        UINT        cbSize;
        UINT        style;
        WNDPROC     lpfnWndProc;
        int         cbClsExtra;
        int         cbWndExtra;
        void*       hInstance;
        void*       hIcon;
        void*       hCursor;
        void*       hbrBackground;
        LPCSTR      lpszMenuName;
        LPCSTR      lpszClassName;
        void*       hIconSm;
    } WNDCLASSEXA, *PWNDCLASSEXA, *NPWNDCLASSEXA, *LPWNDCLASSEXA;
]]