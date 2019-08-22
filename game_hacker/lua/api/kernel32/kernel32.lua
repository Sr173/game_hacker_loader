local ffi = require "ffi"
local bit = require "bit"

local kernel32 = {}

ffi.cdef [[
    DWORD       GetTickCount();
    HANDLE      GetCurrentProcess();
    DWORD       GetCurrentDirectoryA(DWORD lenth,LPSTR lpBuffer);
    DWORD       GetCurrentProcessId();
    HANDLE      OpenProcess(DWORD dwDesiredAccess,BOOL bInheritHandle,DWORD dwProcessId);
    bool        CloseHandle(HANDLE obj);
    int         SendInput(int cInputs, void* pInputs, int cbSize); 
    void*       GetModuleHandleA(LPCSTR);
    int         GetLastError();
    void        Sleep(DWORD);
]]

kernel32.STANDARD_RIGHTS_REQUIRED = 0x000F0000
kernel32.SYNCHRONIZE              = 0x00100000
kernel32.PROCESS_ALL_ACCESS       = bit.bor(kernel32.STANDARD_RIGHTS_REQUIRED,kernel32.SYNCHRONIZE)

kernel32.GetTickCount = ffi.C.GetTickCount
kernel32.GetCurrentProcess = ffi.C.GetCurrentProcess
kernel32.GetCurrentDirectoryA = ffi.C.GetCurrentDirectoryA
kernel32.GetCurrentProcessId = ffi.C.GetCurrentProcessId
kernel32.OpenProcess = ffi.C.OpenProcess
kernel32.CloseHandle = ffi.C.CloseHandle
kernel32.GetModuleHandle = ffi.C.GetModuleHandleA
kernel32.GetLastError = ffi.C.GetLastError
kernel32.Sleep = ffi.C.Sleep

return kernel32