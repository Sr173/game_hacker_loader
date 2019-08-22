local ffi = require "ffi"
local windef = {};

ffi.cdef [[
    typedef unsigned long       DWORD;
    typedef int                 BOOL;
    typedef unsigned char       BYTE;
    typedef unsigned short      WORD;
    typedef float               FLOAT;
    typedef long             LONG;
    typedef FLOAT               *PFLOAT;
    typedef BOOL                *PBOOL;
    typedef BOOL                *LPBOOL;
    typedef BYTE           *PBYTE;
    typedef BYTE            *LPBYTE;
    typedef int            *PINT;
    typedef int              *LPINT;
    typedef WORD            *PWORD;
    typedef WORD             *LPWORD;
    typedef long             *LPLONG;
    typedef DWORD           *PDWORD;
    typedef DWORD            *LPDWORD;
    typedef void             *LPVOID;
    typedef const void       *LPCVOID;
    typedef int                 INT;
    typedef unsigned int        UINT;
    typedef unsigned int        *PUINT;

    typedef char CHAR;
    typedef CHAR *NPSTR, *LPSTR, *PSTR;
    typedef const CHAR *LPCSTR, *PCSTR;

    typedef struct tagRECT
    {
      LONG    left;
      LONG    top;
      LONG    right;
      LONG    bottom;
    } RECT, *PRECT,  *NPRECT,  *LPRECT;

    typedef  int INT_PTR, *PINT_PTR;
    typedef  unsigned int UINT_PTR, *PUINT_PTR;

    typedef  long LONG_PTR, *PLONG_PTR;
    typedef  unsigned long ULONG_PTR, *PULONG_PTR;

    typedef UINT_PTR            WPARAM;
    typedef LONG_PTR            LPARAM;
    typedef LONG_PTR            LRESULT;
]]

windef.MAX_PATH = 260

return windef