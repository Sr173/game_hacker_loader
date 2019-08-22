local ffi = require "ffi"
require "api/common/windef"

ffi.cdef [[
    typedef void *HANDLE;
    typedef HANDLE *PHANDLE;

    typedef struct tagMOUSEINPUT {
        LONG    dx;
        LONG    dy;
        DWORD   mouseData;
        DWORD   dwFlags;
        DWORD   time;
        ULONG_PTR dwExtraInfo;
    } MOUSEINPUT, *PMOUSEINPUT, * LPMOUSEINPUT;


    typedef struct tagKEYBDINPUT {
        WORD    wVk;
        WORD    wScan;
        DWORD   dwFlags;
        DWORD   time;
        ULONG_PTR dwExtraInfo;
    } KEYBDINPUT, *PKEYBDINPUT, * LPKEYBDINPUT;

    typedef struct tagHARDWAREINPUT {
        DWORD   uMsg;
        WORD    wParamL;
        WORD    wParamH;
    } HARDWAREINPUT, *PHARDWAREINPUT, * LPHARDWAREINPUT;


    typedef struct tagINPUT {
        DWORD   type;
        union
        {
            MOUSEINPUT      mi;
            KEYBDINPUT      ki;
            HARDWAREINPUT   hi;
        } DUMMYUNIONNAME;
    } INPUT, *PINPUT;
]]