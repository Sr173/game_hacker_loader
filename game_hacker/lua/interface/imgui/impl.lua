local ffi = require "ffi"
require "api.user32.user32"

local imgui_impl = {}

ffi.cdef [[
    bool sppk72igwvwg1icruuig(HWND);
    LRESULT ky5j6ubqgtrhsxrvosrn(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);
    void uesz166ju7xkm4dngqb4();
    void yjqnshvrnpznlznqklkg();
    void ctzncjzgduzytpxo();
    void gdpgztldsxwsndat(unsigned int rgba);
]]

imgui_impl.CreateDeviceD3D = ffi.C.sppk72igwvwg1icruuig
imgui_impl.ImGui_ImplWin32_WndProcHandler = ffi.C.ky5j6ubqgtrhsxrvosrn
imgui_impl.CleanupDeviceD3D = ffi.C.uesz166ju7xkm4dngqb4
imgui_impl.Init = ffi.C.yjqnshvrnpznlznqklkg
imgui_impl.ResetDevice = ffi.C.ctzncjzgduzytpxo
imgui_impl.EndFrame = ffi.C.gdpgztldsxwsndat

return imgui_impl