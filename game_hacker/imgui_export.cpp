#include "Imgui.h"
#include <d3d9.h>
#define DIRECTINPUT_VERSION 0x0800
#include <tchar.h>
#include "imgui_impl_dx9.h"
#include "imgui_impl_win32.h"
#include <mutex>

static LPDIRECT3D9              g_pD3D = NULL;
static LPDIRECT3DDEVICE9        g_pd3dDevice = NULL;
static D3DPRESENT_PARAMETERS    g_d3dpp = {};

#pragma comment(lib,"d3d9")

/*
 * @sr173
 * CreateDeviceD3D
 */
extern "C" __declspec(dllexport) bool sppk72igwvwg1icruuig(HWND hWnd)
{
	if ((g_pD3D = Direct3DCreate9(D3D_SDK_VERSION)) == NULL)
		return false;

	// Create the D3DDevice
	ZeroMemory(&g_d3dpp, sizeof(g_d3dpp));
	g_d3dpp.Windowed = TRUE;
	g_d3dpp.SwapEffect = D3DSWAPEFFECT_DISCARD;
	g_d3dpp.BackBufferFormat = D3DFMT_UNKNOWN;
	g_d3dpp.EnableAutoDepthStencil = TRUE;
	g_d3dpp.AutoDepthStencilFormat = D3DFMT_D16;
	g_d3dpp.PresentationInterval = D3DPRESENT_INTERVAL_ONE;           // Present with vsync
	//g_d3dpp.PresentationInterval = D3DPRESENT_INTERVAL_IMMEDIATE;   // Present without vsync, maximum unthrottled framerate
	if (g_pD3D->CreateDevice(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, hWnd, D3DCREATE_HARDWARE_VERTEXPROCESSING, &g_d3dpp, &g_pd3dDevice) < 0)
		return false;

	return true;
}

/*
 * @sr173
 * ImGui_ImplWin32_WndProcHandler
 */
extern LRESULT ImGui_ImplWin32_WndProcHandler(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);
extern "C" __declspec(dllexport) LRESULT ky5j6ubqgtrhsxrvosrn(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam)
{
	return ImGui_ImplWin32_WndProcHandler(hWnd, msg, wParam, lParam);
}

/*
 * @sr173
 * CleanupDeviceD3D
 */
extern "C" __declspec(dllexport) void uesz166ju7xkm4dngqb4()
{
	if (g_pd3dDevice) { g_pd3dDevice->Release(); g_pd3dDevice = NULL; }
	if (g_pD3D) { g_pD3D->Release(); g_pD3D = NULL; }
}

/*
 * @sr173
 * Init Imgui Impl
 */
extern "C" __declspec(dllexport) void yjqnshvrnpznlznqklkg(HWND hwnd)
{
	ImGui_ImplWin32_Init(hwnd);
	ImGui_ImplDX9_Init(g_pd3dDevice);
}

/*
 * @sr173
 * ImplNewFrame
 */
extern "C" __declspec(dllexport) void ctzncjzgduzytpxo()
{
	ImGui_ImplDX9_NewFrame();
	ImGui_ImplWin32_NewFrame();
}

/*
 * @sr173
 * ResetDevice
 */
extern "C" __declspec(dllexport) void wfdwgrzarqpghshn()
{
	ImGui_ImplDX9_InvalidateDeviceObjects();
	HRESULT hr = g_pd3dDevice->Reset(&g_d3dpp);
	if (hr == D3DERR_INVALIDCALL)
		IM_ASSERT(0);
	ImGui_ImplDX9_CreateDeviceObjects();
}

/*
 * @sr173
 * EndFrame
 */
extern "C" __declspec(dllexport) void gdpgztldsxwsndat(unsigned int rgba)
{
	g_pd3dDevice->SetRenderState(D3DRS_ZENABLE, false);
	g_pd3dDevice->SetRenderState(D3DRS_ALPHABLENDENABLE, false);
	g_pd3dDevice->SetRenderState(D3DRS_SCISSORTESTENABLE, false);
	g_pd3dDevice->Clear(0, NULL, D3DCLEAR_TARGET | D3DCLEAR_ZBUFFER, rgba, 1.0f, 0);
	if (g_pd3dDevice->BeginScene() >= 0)
	{
		ImGui::Render();
		ImGui_ImplDX9_RenderDrawData(ImGui::GetDrawData());
		g_pd3dDevice->EndScene();
	}
	HRESULT result = g_pd3dDevice->Present(NULL, NULL, NULL, NULL);

	// Handle loss of D3D9 device
	if (result == D3DERR_DEVICELOST && g_pd3dDevice->TestCooperativeLevel() == D3DERR_DEVICENOTRESET)
		wfdwgrzarqpghshn();
}

/*
 * @Sr173
 * utf8_2_gbk
 */
extern "C" __declspec(dllexport) const char* gdpgztldsxwsndatt(const char* strUTF8)
{
	static std::mutex mutex;
	std::lock_guard<std::mutex> lock_(mutex);

	static wchar_t wszGBK[0x1000];
	static char szGBK[0x1000];

	int len = MultiByteToWideChar(CP_UTF8, 0, strUTF8, -1, NULL, 0);
	memset(wszGBK, 0, len * 2 + 2);
	MultiByteToWideChar(CP_UTF8, 0, strUTF8, -1, wszGBK, len);
	len = WideCharToMultiByte(CP_ACP, 0, wszGBK, -1, NULL, 0, NULL, NULL);
	memset(szGBK, 0, len + 1);
	WideCharToMultiByte(CP_ACP, 0, wszGBK, -1, szGBK, len, NULL, NULL);

	return szGBK;
}